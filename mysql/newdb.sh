#!/bin/sh

echo "Usage $0 <USER> <PASSWORD>"
echo ""

USER=${1:-jdoe}
PASSWORD="$2"

if test -z "$PASSWORD"; then
	PASSWORD=$(head -c64 /dev/random | base64 | head -c16)
fi

echo "mysql -u root -p"
echo "CREATE USER '$USER'@'%' IDENTIFIED BY '$PASSWORD';"
echo "CREATE USER '$USER'@'localhost' IDENTIFIED BY '$PASSWORD';"
echo "CREATE DATABASE $USER;"
echo "GRANT ALL PRIVILEGES ON $USER.* TO '$USER'@'%';"
echo "GRANT ALL PRIVILEGES ON $USER.* TO '$USER'@'localhost';"
echo "FLUSH PRIVILEGES;"
echo "EXIT;"

