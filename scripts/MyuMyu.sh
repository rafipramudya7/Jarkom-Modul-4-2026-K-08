
cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.215.24.3
    netmask 255.255.255.128
    up ip route add default via 192.215.24.1

EOF

ip addr flush dev eth0
ip addr add 192.215.24.3/25 dev eth0
ip link set eth0 up
ip route replace default via 192.215.24.1

echo "== Selesai: MyuMyu =="
ip -4 addr; ip route
