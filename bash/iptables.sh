#!/bin/sh
# This script will configure iptables to drop all incoming traffic except port 22 and 80 (ssh & http)

echo "Setting default iptables policy..."
sudo iptables -P INPUT ACCEPT
sudo iptables -P OUTPUT ACCEPT

echo "Flushing iptables..."
sudo iptables -F

echo "Adding iptables rules..."
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT 
iptables -A INPUT -p tcp --dport 22 -j ACCEPT # ssh
iptables -A INPUT -p tcp --dport 80 -j ACCEPT # http
iptables -I INPUT 1 -i lo -j ACCEPT # loopback device
iptables -P INPUT DROP

iptables -A INPUT -j DROP

echo "Installing iptables-persistent..."
apt-get install iptables-persistent
service iptables-persistent status
echo "Done!"
