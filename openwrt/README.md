# Open WRT

## Links

[Table of Hardware](https://openwrt.org/toh/views/toh_fwdownload)


## Configuration



### Ad blocker

Install packages `simple-adblock` and `luci-app-simple-adblock` for configuration from the web interface.


### Forward avahi between zones

```
vim /etc/avahi/avahi-daemon.conf
```

In the `reflector` section, set 

```ini
[reflector]
enable-reflector=yes
```

