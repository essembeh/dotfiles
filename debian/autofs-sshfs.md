# Setup _autofs_ with _sshfs_

> Commands as _root_

> All variables `__xxx__` have to be replaced

```sh
# install packages
apt install autofs sshfs

# generate a key without passphrase
ssh-keygen -t ed25519 -f ~/.ssh/id_sshfs

# copy it to the remote server
ssh-cop-id __USER__@__ADDRESS__
```

Create _Host_ in `~/.ssh/config`

```
Host __ALIAS__
    Hostname __ADDRESS__
    User __USER__
    IdentityFile ~/.ssh/id_sshfs
```

Test it

```sh
ssh __ALIAS__
```

Edit `/etc/auto.master`

```
/media/sshfs    /etc/auto.sshfs uid=1000,gid=1000,--timeout=30,--ghost
```

Create `/etc/auto.sshfs`

```
__ALIAS__ -fstype=fuse,port=22,rw,allow_other :sshfs\#__ALIAS__\:/path/to/shared/folder
```

Restart _autofs_

```sh
service autofs restart
```

Access content

```sh
ls -l /media/sshfs/__ALIAS__/
```
