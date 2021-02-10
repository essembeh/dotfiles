# Install 

For Debian Buster, you need to enable *backports* repository
```sh 
$ cat << EOF > /etc/apt/sources.list.d/backports.list
## Backports
deb http://ftp.fr.debian.org/debian/ buster-backports main contrib non-free
EOF
$ apt update
$ apt install wireguard
```

# Server

Generate keys for the server and one client
```sh 
# server
$ wg genkey | tee server.key | wg pubkey > server.pub
# client
$ wg genkey | tee client.key | wg pubkey > client.pub
```

Configuration file, usually `/etc/wireguard/wg0.conf`
```ini
[Interface]
PrivateKey = {SERVER_PRIVATE_KEY}
ListenPort = 51820
Address = 10.0.0.1/32

[Peer]
PublicKey = {CLIENT_PUBLIC_KEY}
AllowedIPs = 10.0.0.2/32
```
> Note: replace `{SERVER_PRIVATE_KEY}` with the content of `server.key`

> Note: replace `{CLIENT_PUBLIC_KEY}` with the content of `client.key`

Enable via *systemd*
```sh
$ systemctl enable wg-quick@wg0
$ systemctl start wg-quick@wg0
```

# Firewall

Enable IP forward
```sh
$ echo 1 > /proc/sys/net/ipv4/ip_forward
```

Enable IP forward in `/etc/sysctl.conf` on boot
```ini
...
# Uncomment the next line to enable packet forwarding for IPv4
net.ipv4.ip_forward=1
...
```

Install *UFW*
```sh
$ apt install ufw
# open ssh port
$ ufw allow in 22/tcp
# open wireguard port
$ ufw allow in 51820/udp
# enable the firewall
$ ufw enable
```

Edit `/etc/default/ufw`
```ini
...
DEFAULT_FORWARD_POLICY="ACCEPT"
...
```

Edit `/etc/ufw/before.rules` and add these lines at the begining
```ini
*nat
:POSTROUTING ACCEPT [0:0]
-A POSTROUTING -s 10.0.0.0/24 -o {PUBLIC_INTERFACE} -j MASQUERADE
COMMIT
```

Reload *Wireguard* configuration
```sh
$ ufw reload
```

# Client

Configuration file, usually `client.conf`

```ini
[Interface]
Address = 10.0.0.2/24
PrivateKey = {CLIENT_PRIVATE_KEY}
DNS = 9.9.9.9

[Peer]
PublicKey = {SERVER_PUBLIC_KEY}
Endpoint = {SERVER_ADDRESS}:51820
AllowedIPs = 0.0.0.0/0
```
> Note: replace `{CLIENT_PRIVATE_KEY}` with the content of `client.pub`

> Note: replace `{SERVER_PUBLIC_KEY}` with the content of `server.key`

> Note: replace `{SERVER_ADDRESS}` with the address of the server

Generate a *QR code*
```sh
$ apt install qrencode
$ qrencode -t ansiutf8 < client.conf
█████████████████████████████████████
█████████████████████████████████████
████ ▄▄▄▄▄ █▀█ █▄▀ ▀▄▄▄▄ █ ▄▄▄▄▄ ████
████ █   █ █▀▀▀█ ▀▄  ▀▀ ▄█ █   █ ████
████ █▄▄▄█ █▀ █▀▀▄▄▀▀ ▄▄ █ █▄▄▄█ ████
████▄▄▄▄▄▄▄█▄▀ ▀▄█ █ █▄▀▄█▄▄▄▄▄▄▄████
████▄ ▄▄ ▀▄  ▄▀▄▀█ ▄ ▄█▀▀▄▀ ▀▄█▄▀████
████ ▄ ▀▄█▄▄ █▄█▀▄  ▄▄█▀▀▄▄▀█▀█▀█████
██████▄ ▀█▄ ▄▄▄█▄▄▄  ▄▀ █▀▀█▀▄▄█▀████
████▀███ █▄ █▀  ▄▄  ▀█▄█ █  ▀▄▄▀█████
████ ▄▄█  ▄  ▄▄▄▀▀ ▄▀▄█▀▀█▀ ▀▄ █▀████
████ █ ▀▄█▄▀▀▄▀█▀██  █▀▀███ ▀█▄▀█████
████▄█▄█▄▄▄█▀ ▀█▄▄▄█▄▄▀█ ▄▄▄ ▀   ████
████ ▄▄▄▄▄ █▄▀▄ ▄▄▀▄▀▄▄  █▄█ ▄▄▀█████
████ █   █ █ ▄▀▄ █ ▄  ▀▀▄▄▄ ▄▀ ▀ ████
████ █▄▄▄█ █ █▄▀ █▀▄ █  ▀█▄ ▄ ▄ █████
████▄▄▄▄▄▄▄█▄▄█▄▄███▄▄▄▄█▄█▄▄▄▄██████
█████████████████████████████████████
█████████████████████████████████████
```
And scan it from the *Wireguard* app on iOS or Android.