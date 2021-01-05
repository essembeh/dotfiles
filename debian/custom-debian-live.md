# Custom Debian Live USB

[Official documentation](https://live-team.pages.debian.net/live-manual/)

## Prereq

```sh
$ sudo apt install live-build
```

## Configure the image

```sh
$ mkdir live
$ cd live
$ lb config --distribution buster --archive-areas "main contrib non-free"
```
> Note: enabling *non-free* will install non-free firmwares

Edit `config/binary` and update `LB_BOOTAPPEND_LIVE` to add custom parameters:
```ini
LB_BOOTAPPEND_LIVE="... locales=fr_FR.UTF-8 keyboard-layouts=fr,fr keyboard-variants=latin9,mac"
```

Create `config/package-lists/mypackages.list.chroot` and add your packages
```txt
task-gnome-desktop
task-french
cryptsetup
```


## Build the image

```sh
$ sudo lb build
```

Copy the image on the usb key
```sh
$ sudo dd if=my-custom-live-amd64.hybrid.iso of=/dev/sdX bs=1M 
```
> Note: use `lsblk` to identify your device

You can use `qemu` to test the image
```sh
$ sudo apt install qemu-system
# BIOS
$ qemu-system-x86_64 \
    -enable-kvm -cpu host -m 2048 -smp 4 \
    -drive media=cdrom,format=raw,file=live-image-amd64.hybrid.iso -boot d
# EFI
$ qemu-system-x86_64 \
    -enable-kvm -cpu host -m 2048 -smp 4 \
    -bios /usr/share/ovmf/OVMF.fd -vga virtio \
    -drive media=cdrom,format=raw,file=live-image-amd64.hybrid.iso -boot d
```


## Setup persistence

To enable *persistence* with a *LUKS* partition add kernel parameters before building the image:
```ini
LB_BOOTAPPEND_LIVE="... persistence persistence-encryption=luks"
```

Build the image, after copying the generated ISO on your *usb key*, create a partition on it
```sh
$ sudo fdisk /dev/sdX

Welcome to fdisk (util-linux 2.33.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): p
Disk /dev/sdX: 7.5 GiB, 8039890944 bytes, 15702912 sectors
Disk model: Voyager         
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xad675e49

Device     Boot Start     End Sectors  Size Id Type
/dev/sdX1  *       64 2621439 2621376  1.3G  0 Empty
/dev/sdX2         708    6403    5696  2.8M ef EFI (FAT-12/16/32)

Command (m for help): n
Partition type
   p   primary (2 primary, 0 extended, 2 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (3,4, default 3): 
First sector (2621440-15702911, default 2621440): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2621440-15702911, default 15702911): 

Created a new partition 3 of type 'Linux' and of size 6.2 GiB.

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```

Create the *LUKS* partition
```sh
$ sudo cryptsetup luksFormat /dev/sdX3
$ sudo cryptsetup luksOpen /dev/sdX3 persistence
$ sudo mkfs.ext4 /dev/mapper/persistence -L persistence
$ mkdir target
$ sudo mount /dev/mapper/persistence target
$ echo "/ union" | sudo tee target/persistence.conf
$ sudo umount target
$ sudo cryptsetup luksClose persistence
```
