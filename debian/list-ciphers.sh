#!/bin/sh
set -eu

nmap --script ssl-enum-ciphers -p 443 $1
