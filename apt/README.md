# Debian bullseye

Here are the main repositories

```sh
## Debian official repositories
deb http://ftp.fr.debian.org/debian/ bullseye main contrib non-free
deb http://ftp.fr.debian.org/debian/ bullseye-updates main contrib non-free
deb http://security.debian.org/debian-security bullseye-security main contrib non-free
#deb http://ftp.fr.debian.org/debian/ bullseye-backports main contrib non-free
```

And the source repositories

```sh
## Debian official repositories (source)
deb-src http://ftp.fr.debian.org/debian/ bullseye main contrib non-free
deb-src http://ftp.fr.debian.org/debian/ bullseye-updates main contrib non-free
deb-src http://security.debian.org/ bullseye/updates main contrib non-free
#deb-src http://ftp.fr.debian.org/debian/ bullseye-backports main contrib non-free
```

# Debian testing

```sh
## Debian testing official repositories
deb http://ftp.fr.debian.org/debian/ testing main contrib non-free
deb http://ftp.fr.debian.org/debian/ testing-updates main contrib non-free
deb http://security.debian.org/debian-security/ testing-security main contrib non-free
```

# Debian unstable

```sh
## Debian unstable official repositories
deb http://ftp.fr.debian.org/debian/ unstable main contrib non-free
```

# Ubuntu

> Note: replace `{RELEASE}` with the release name

```sh
## Ubuntu official repositories
deb http://fr.archive.ubuntu.com/ubuntu {RELEASE} main restricted universe multiverse
deb http://fr.archive.ubuntu.com/ubuntu {RELEASE}-security main restricted universe multiverse
deb http://fr.archive.ubuntu.com/ubuntu {RELEASE}-updates main restricted universe multiverse
deb http://fr.archive.ubuntu.com/ubuntu {RELEASE}-backports main restricted universe multiverse
```
