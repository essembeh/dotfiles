# Install a fully encrypted remote server on Debian Buster 

This doc was inspired by some online posts:
- https://blog.tincho.org/posts/Setting_up_my_server:_re-installing_on_an_encripted_LVM/


> For the next commands, `__SERVER__` must be replaced by the IP address of the server


First copy your public SSH key 
```
ssh-copy-id root@__SERVER__
```


(OPTIONAL) Install and use tmux not to interrupt current operation in case of ssh disconnect
```
apt install tmux
wget -q https://raw.githubusercontent.com/essembeh/dotfiles/master/tmux/tmux.conf -O ~/.tmux.conf
tmux
```


Create partitions
```
parted /dev/sda mklabel msdos
parted --align=optimal /dev/sda mkpart primary 0% 200
parted /dev/sda set 1 boot on
mkfs.ext4 -L boot /dev/sda1
parted --align=optimal /dev/sda mkpart primary 200 100%
```


Encrypt the main partition
```
cryptsetup luksFormat /dev/sda2
cryptsetup luksOpen /dev/sda2 sda2_crypt
```


Create the others partitions
```
pvcreate /dev/mapper/sda2_crypt
vgcreate vg0 /dev/mapper/sda2_crypt
lvcreate -L 4g -n swap vg0
lvcreate -L 40g -n system vg0
lvcreate -l 100%FREE -n home vg0
mkswap -L swap /dev/mapper/vg0-swap
swapon /dev/mapper/vg0-swap
mkfs.ext4 -L system /dev/mapper/vg0-system
mkfs.ext4 -L home -m 0 /dev/mapper/vg0-home
```

## Install Debian


Create the *chroot* environment
```
mkdir /target
mount /dev/mapper/vg0-system /target
mkdir /target/boot
mount /dev/sda1 /target/boot
mkdir /target/home
mount /dev/mapper/vg0-home /target/home
mkdir /target/tmp
chmod 1777 /target/tmp
```


Install Debian in the chroot
```
apt-get install -y debootstrap
debootstrap --verbose --arch amd64 --components=main buster /target http://debian.mirrors.ovh.net/debian
# -- OR --
debootstrap --verbose --arch amd64 --components=main buster /target http://deb.debian.org/debian
```


Setup the chroot
```
echo "sda2_crypt UUID=$(cryptsetup luksDump /dev/sda2 | awk '/^UUID:/ {print $2}') none luks" > /target/etc/crypttab
mkdir /target/root/.ssh
cp ~/.ssh/authorized_keys /target/root/.ssh/authorized_keys
# -- or --
cp ~/.ssh/authorized_keys2 /target/root/.ssh/authorized_keys
test -f /etc/adjtime && cp /etc/adjtime /target/etc/
echo FSCKFIX=yes >> /target/etc/default/rcS
```


Enter the *chroot*
> The udev bindings commands fix the error `Device /dev/loop0 not initialized in udev database even after waiting 10000000 microseconds.`
```
mkdir /target/hostudev
mount --bind /run/udev /target/hostudev 
mount -o bind /dev /target/dev
mount -t proc proc /target/proc
mount -t sysfs sys /target/sys
chroot /target /bin/bash
ln -s /hostudev /run/udev
```

Retrieve the *network interface name* with:
```
udevadm test-builtin net_id /sys/class/net/eth0 2>/dev/null
```

Export some variables
```
# Replace vars as needed
export IFACE=enp1s0
export HOSTNAME=foo
export DOMAIN=
```


Setup the system
```
ln -sf /proc/mounts /etc/mtab
cat >> /etc/fstab << EOF
/dev/mapper/vg0-system  /      ext4  errors=remount-ro  0  1
/dev/sda1               /boot  ext4  defaults           0  2
/dev/mapper/vg0-home    /home  ext4  defaults           0  2
/dev/mapper/vg0-swap    none   swap  sw                 0  0
EOF

cat >> /etc/network/interfaces << EOF
auto lo
iface lo inet loopback
auto $IFACE
iface $IFACE inet dhcp
EOF

echo $HOSTNAME > /etc/hostname
hostname $HOSTNAME
echo "127.0.1.1    $HOSTNAME $HOSTNAME.$DOMAIN" >> /etc/hosts
```


(OPTIONNAL) Disable IPV6 
```
cat >> /etc/sysctl.conf << EOF
# Disable IPv6
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.all.autoconf = 0
net.ipv6.conf.all.accept_ra = 0
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.default.autoconf = 0
net.ipv6.conf.default.accept_ra = 0
EOF
```


Install some packages
```
apt update
apt install -y cryptsetup lvm2 makedev dropbear busybox ssh initramfs-tools linux-base linux-image-amd64 grub-pc console-setup kbd locales ntp
dpkg-reconfigure tzdata locales
```


You can also install any extra package
```
apt install -y tmux zsh vim git
```


## Setup dropbear in initramfs
```
cp /root/.ssh/authorized_keys /etc/dropbear-initramfs/authorized_keys
update-initramfs -u
```


Check the initramfs
```
zcat /boot/initrd.img-* | cpio -t conf/conf.d/cryptroot etc/lvm/lvm.conf etc/dropbear/\* root\*/.ssh/authorized_keys sbin/dropbear | sort
	--- stdout ---
	202797 blocks
	etc/dropbear/config
	etc/dropbear/dropbear_dss_host_key
	etc/dropbear/dropbear_ecdsa_host_key
	etc/dropbear/dropbear_rsa_host_key
	etc/lvm/lvm.conf
	root-ZSMmDr/.ssh/authorized_keys


zcat /boot/initrd.img-* | cpio -i --to-stdout cryptroot/crypttab
	--- stdout ---
	sda2_crypt UUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX none luks

zcat /boot/initrd.img-* | cpio -i --to-stdout root-\*/.ssh/authorized_keys
	--- stdout ---
	ssh-rsa AAAAB3[...]== me@MyComputer

```


Installation is finished, reboot
```
exit
umount /target/{dev,proc,sys,boot,home,hostudev} /target
swapoff -a
lvchange -an /dev/mapper/vg0-*
cryptsetup luksClose sda2_crypt
reboot
```

## Unlock the remote system when booted

Unless your Dropbear and yout Openssh has the same keys, you will get an SSH error each time you connect.


You can configure your `~/.ssh/config` to add a new *luks* host by adding these lines:

```
Host luks
Hostname __SERVER__
User root
UserKnownHostsFile ~/.ssh/known_hosts.luks
```

To unlock, connect to the dropbear after booting
```
ssh -o UserKnownHostsFile=~/.ssh/known_hosts.luks root@__SERVER__
-- or --
ssh luks

```
Then in remote shell
```
cryptroot-unlock
-- or --
echo -n YOUR_LUKS_PASSWORD >/lib/cryptsetup/passfifo
```

## Unlock from the rescue mode

First select the *rescue* in the *netboot* option from your dashboard.

Once reboot done:
```
cryptsetup luksOpen /dev/sda2 sda2_crypt
vgchange -a y
mkdir /target
mount /dev/mapper/vg0-system /target
mount /dev/sda1 /target/boot
mount /dev/mapper/vg0-home /target/home
mount --bind /run/udev /target/hostudev 
mount -o bind /dev /target/dev
mount -t proc proc /target/proc
mount -t sysfs sys /target/sys
chroot /target /bin/bash
ln -s /hostudev /run/udev


# To reboot
exit
umount /target/{dev,proc,sys,boot,home,hostudev} /target
swapoff -a
lvchange -an /dev/mapper/vg0-*
cryptsetup luksClose sda2_crypt
reboot
```
