# Encrypted swap

Edit `/etc/crypttab`

```
# <target>  <source>   <key file>    <options>
cswap       /dev/sda6  /dev/urandom  swap,cipher=aes-cbc-essiv:sha256
home        /dev/sda1  none          luks
```

Edit `/etc/fstab`

```
# <file system> <mount point> <type> <options> <dump> <pass>
/dev/mapper/cswap none swap sw 0 0
/dev/mapper/home /home ext4 defaults 0 1
```
