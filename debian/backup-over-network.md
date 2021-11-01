# Backup over network

To backup `sda` drive from `laptop` to `storage`

## Using ssh

```sh
# without compression
root@storage:~$ ssh root@storage.lan "dd if=/dev/sda bs=16M" | dd of=backup-sda.img
# use pv for info
root@storage:~$ ssh root@storage.lan "dd if=/dev/sda bs=16M" | pv | dd of=backup-sda.img
# with compression on laptop side
root@storage:~$ ssh root@storage.lan "dd if=/dev/sda bs=16M | bzip2 -c" | pv | dd of=backup-sda.img.bzip2
# with compression on storage side
root@storage:~$ ssh root@storage.lan "dd if=/dev/sda bs=16M" | pv | bzip2 -c | dd of=backup-sda.img.bzip2
```


## Using netcat

On `storage`
```sh
# without compression
root@storage:~$ nc -lvp 4242 | dd of=backup-sda.img
# use pv for info
root@storage:~$ nc -lvp 4242 | pv | dd of=backup-sda.img
# compression on storage side
root@storage:~$ nc -lvp 4242 | pv | bzip2 -c | dd of=backup-sda.img.bzip2
```

On `laptop`
```sh
# without compression
root@laptop:~$ dd if=/dev/sda bs=16M | nc storage.lan 4242
# with compression on laptop side
root@laptop:~$ dd if=/dev/sda bs=16M | bzip2 -c | nc storage.lan 4242
```

