#!/bin/bash
# Konfigurasi GNS3 node: Copland
# Jalankan di console node (root). Skrip menulis /etc/network/interfaces
# lalu langsung menerapkan IP dan routing tanpa perlu restart.

cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.215.12.19
    netmask 255.255.255.248
    up ip route add default via 192.215.12.17

auto eth1
iface eth1 inet static
    address 192.215.6.1
    netmask 255.255.255.192

auto eth2
iface eth2 inet static
    address 192.215.4.1
    netmask 255.255.254.0
    up echo 1 > /proc/sys/net/ipv4/ip_forward

EOF

# --- Terapkan langsung ---
ip addr flush dev eth0
ip addr add 192.215.12.19/29 dev eth0
ip link set eth0 up
ip addr flush dev eth1
ip addr add 192.215.6.1/26 dev eth1
ip link set eth1 up
ip addr flush dev eth2
ip addr add 192.215.4.1/23 dev eth2
ip link set eth2 up
ip route replace default via 192.215.12.17
echo 1 > /proc/sys/net/ipv4/ip_forward

echo "== Selesai: Copland =="
ip -4 addr; ip route
