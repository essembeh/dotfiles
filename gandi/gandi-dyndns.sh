#!/bin/sh
set -eux

if [ $# -lt 2 -o $# -gt 3 ]; then
    echo "Simple tool to update Gandi.net DNS record using your current IP address

Usage: 
  $0 <API_KEY> <DOMAIN> [SUBDOMAIN]

Example: 
  $0 dQw4w9WgXcQ example.org dynamic
      will update dynamic.example.org with current public ip address
      obtained using https://ifconfig.io"
    exit 1
fi
API_TOKEN="$1"
DOMAIN="$2"
API_URL="https://api.gandi.net/v5/livedns/domains/$DOMAIN/records"
if [ $# -eq 3 ]; then
	API_URL="$API_URL/$3"
fi

echo "Current config:"
curl -s -X GET "$API_URL" -H "Authorization: Apikey $API_TOKEN"
echo ""
MY_ADDRESS=$(curl -s https://ifconfig.io)
echo "$MY_ADDRESS" | grep -qE "^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}$"
echo "Update with address $MY_ADDRESS using api $API_URL"
curl -s -X PUT "$API_URL" -H "Authorization: Apikey $API_TOKEN" -H "Content-Type: application/json" --data-binary @- << EOF
{"items":[{"rrset_type":"A","rrset_ttl":3600,"rrset_values":["$MY_ADDRESS"]}]}
EOF
echo ""
