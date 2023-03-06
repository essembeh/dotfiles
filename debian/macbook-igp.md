# Debian on Macbook

## Force Intel IGP

Install `sysfsutils`

```sh
apt install sysfsutils
```

Create `/etc/sysfs.d/force-igp.conf`

```
kernel/debug/vgaswitcheroo/switch = DIGD
```
