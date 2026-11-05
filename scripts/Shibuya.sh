
cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.215.21.166
    netmask 255.255.255.252
    up ip route add default via 192.215.21.165

auto eth1
iface eth1 inet static
    address 192.215.21.193
    netmask 255.255.255.192
    up echo 1 > /proc/sys/net/ipv4/ip_forward

EOF

ip addr flush dev eth0
ip addr add 192.215.21.166/30 dev eth0
ip link set eth0 up
ip addr flush dev eth1
ip addr add 192.215.21.193/26 dev eth1
ip link set eth1 up
ip route replace default via 192.215.21.165
echo 1 > /proc/sys/net/ipv4/ip_forward

echo "== Selesai: Shibuya =="
ip -4 addr; ip route
