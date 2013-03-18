#!/bin/bash

iptables -A OUTPUT -p tcp -d 173.194.52.0/22 -j REJECT --reject-with tcp-reset
