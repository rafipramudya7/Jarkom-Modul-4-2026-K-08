
cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.215.8.3
    netmask 255.255.252.0
    up ip route add default via 192.215.8.1

EOF

ip addr flush dev eth0
ip addr add 192.215.8.3/22 dev eth0
ip link set eth0 up
ip route replace default via 192.215.8.1

echo "== Selesai: Denpa =="
ip -4 addr; ip route
