# Auto unlock LUKS using a keyfile on from USB key or SD cardkey


First install Debian using the full disk encryption method in the installer.

Once installed, after the *Grub* menu, a passphrase is asked to unlock the LUKS device. 

Here are the steps to automatically unlock the LUKS device using an USB key or SD card.

## Prepare the USB key or SD card

> Note: you need to identify the partition, in this example we will use `/dev/sdc1`

```
$ mkfs.ext4 -L LUKSKEY /dev/sdc1 
```

 You can use any file as a keyfile, or you can create a random file too
 ```
 $ mount /dev/sdc1 /mnt

 --- Use an existing file ---
 $ cp /path/to/file /mnt/.key

 --- or generate a random file ---
 $ dd if=/dev/urandom of=/mnt/.key bs=1024 count=4
 ```

## Configure crypttab

The default `/etc/crypttab` should look like:
```
sda3_crypt UUID=12345678-1234-5678-9012-87654321 none luks
```

Simply change it to 
```
sda3_crypt UUID=12345678-1234-5678-9012-87654321 /dev/disk/by-label/LUKSKEY:/.key:1 luks,keyscript=/lib/cryptsetup/scripts/passdev,tries=1
```

> You can reference the partition containing the *key* by its *UUID* but I prefer using the *label* we used with `mkfs.ext4`, it is easier to create another USB that contains the key in case I loose the first one.


Update the *initramfs*
```sh
$ update-initramfs -k all -u
```

Simply reboot with the USB key plugged, the LUKS device should unlock automatically.

# Troubleshooting

## Pending systemd job during boot

Using this method on Debian 10, I get a blocking systemd job during boot which waits 30seconds ...

I ended up adding `rd.luks.crypttab=yes luks.crypttab=no` line to my kernel command line.


Edit `/etc/default/grub`
```
...
GRUB_CMDLINE_LINUX_DEFAULT="quiet rd.luks.crypttab=yes luks.crypttab=no"
...
```
> Do not forget to run `update-grub` after 

## No passphrase fallback

Unfortunatly `passdev` ([source code here](https://sources.debian.org/src/cryptsetup/2:2.1.0-5+deb10u2/debian/scripts/passdev.c/)) does not allow entering a passphrase if the USB key cannot be found.

If the USB key is not plugged at boot, you will end in the boot *busybox* shell where you can unlock the luks device manually:

```sh
(initramfs) cryptsetup luksOpen /dev/sda3 sda3_crypt
Enter passphrase for /dev/sda3: 
(initramfs) lvm vgchange -ay
(initramfs) exit
```
