#!/bin/bash
# Konfigurasi GNS3 node: Hodgeson
# Jalankan di console node (root). Skrip menulis /etc/network/interfaces
# lalu langsung menerapkan IP dan routing tanpa perlu restart.

cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.215.21.3
    netmask 255.255.255.192
    up ip route add default via 192.215.21.1

EOF

# --- Terapkan langsung ---
ip addr flush dev eth0
ip addr add 192.215.21.3/26 dev eth0
ip link set eth0 up
ip route replace default via 192.215.21.1

echo "== Selesai: Hodgeson =="
ip -4 addr; ip route
