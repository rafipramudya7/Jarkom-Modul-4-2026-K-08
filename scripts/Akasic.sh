
cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.215.12.2
    netmask 255.255.255.248
    up ip route add default via 192.215.12.1

EOF

ip addr flush dev eth0
ip addr add 192.215.12.2/29 dev eth0
ip link set eth0 up
ip route replace default via 192.215.12.1

echo "== Selesai: Akasic =="
ip -4 addr; ip route
