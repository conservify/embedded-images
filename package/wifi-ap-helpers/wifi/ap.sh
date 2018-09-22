#!/bin/bash

set -xe

ifconfig wlan0 192.168.4.1

sysctl -w net.ipv4.ip_forward=1
iptables -t nat -F
iptables -t nat -A  POSTROUTING -o eth0 -j MASQUERADE

mkdir -p /var/lib/misc

trap 'killall' INT

killall() {
    trap '' INT TERM # Ignore
    echo "Killing background processes..."
    kill -TERM 0
    wait
    echo "Bye."
}

echo "Starting dnsmasq..."

dnsmasq -k -C ~/wifi/dnsmasq.conf &

sleep 1


echo "Starting hostapd..."

hostapd ~/wifi/hostapd.conf &

sleep 1

cat

