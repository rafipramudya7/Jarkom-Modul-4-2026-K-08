
cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.215.20.134
    netmask 255.255.255.252
    up ip route add default via 192.215.20.133

auto eth1
iface eth1 inet static
    address 192.215.21.65
    netmask 255.255.255.252
    up ip route add 192.215.21.128/25 via 192.215.21.66

auto eth2
iface eth2 inet static
    address 192.215.21.1
    netmask 255.255.255.192
    up echo 1 > /proc/sys/net/ipv4/ip_forward

EOF

ip addr flush dev eth0
ip addr add 192.215.20.134/30 dev eth0
ip link set eth0 up
ip addr flush dev eth1
ip addr add 192.215.21.65/30 dev eth1
ip link set eth1 up
ip addr flush dev eth2
ip addr add 192.215.21.1/26 dev eth2
ip link set eth2 up
ip route replace default via 192.215.20.133
ip route replace 192.215.21.128/25 via 192.215.21.66
echo 1 > /proc/sys/net/ipv4/ip_forward

echo "== Selesai: Protocol7 =="
ip -4 addr; ip route
