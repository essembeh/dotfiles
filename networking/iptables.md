# iptables commands

## For local gateway

```sh
iptables -t nat -A POSTROUTING -s 192.168.42.0/24 -o wlan1 -j MASQUERADE
```

## To allow OpenVpn to access lan

```sh
iptables -t nat -A POSTROUTING -s 10.8.1.0/24 -o wlan1 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.8.2.0/24 -o wlan1 -j MASQUERADE
```

# Script iptables pour permettre le PK sur le port 22 sauf pour les IP locales

```sh
iptables -A INPUT -p tcp -m state --state NEW --dport 22 -j DROP
iptables -I INPUT -s 192.168.0.0/24 -p tcp --dport 22 -j ACCEPT
iptables -D INPUT -p tcp --dport 8000:8099 -j DROP
```
