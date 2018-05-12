#!/bin/sh

echo "Usage $0 <USER> <PASSWORD>"
echo ""

NAME=${1:-jdoe}
USER="$NAME@localhost"
PASSWORD="$2"

if test -z "$PASSWORD"; then
	PASSWORD=`head -c64 /dev/random | base64 | head -c16`
fi

echo "mysql -u root -p"
echo "create user $USER identified by '$PASSWORD';"
echo "create database $NAME;"
echo "grant all privileges on $NAME.* to $USER;"
echo "flush privileges;"
echo "exit;"

