#!/bin/bash

ip=$(dig @185.51.200.2 $1 +short)
echo "$ip $1 #added by shecan script : ~/Documents/scripts/shecan.sh" >> /etc/hosts
echo "found $ip for  $1"
