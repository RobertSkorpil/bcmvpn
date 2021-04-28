#!/bin/sh
iptables -t nat -I POSTROUTING -o gpd0 -j MASQUERADE
#globalprotect set-preferred-gateway --name Frankfurt
