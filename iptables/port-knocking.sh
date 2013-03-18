#!/bin/bash
# Script iptables pour permettre le PK sur le port 22 sauf pour les IP locales

## Bloquer le port 22
/sbin/iptables -A INPUT -p tcp -m state --state NEW --dport 22 -j DROP

## Exception pour le port 22 
# Réseau local
/sbin/iptables -I INPUT -s 192.168.0.0/24 -p tcp --dport 22 -j ACCEPT

## Dropper les ports utilisés pour le PK 
/sbin/iptables -D INPUT -p tcp --dport 8000:8099 -j DROP
