
cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.215.24.130
    netmask 255.255.255.252
    up ip route add default via 192.215.24.129

auto eth1
iface eth1 inet static
    address 192.215.18.65
    netmask 255.255.255.252
    up ip route add 192.215.16.0/22 via 192.215.18.66

auto eth2
iface eth2 inet static
    address 192.215.20.137
    netmask 255.255.255.252
    up ip route add 192.215.20.0/22 via 192.215.20.138

auto eth3
iface eth3 inet static
    address 192.215.12.17
    netmask 255.255.255.248
    up ip route add 192.215.0.0/22 via 192.215.12.18
    up ip route add 192.215.4.0/22 via 192.215.12.19
    up ip route add 192.215.8.0/21 via 192.215.12.20
    up echo 1 > /proc/sys/net/ipv4/ip_forward

EOF

ip addr flush dev eth0
ip addr add 192.215.24.130/30 dev eth0
ip link set eth0 up
ip addr flush dev eth1
ip addr add 192.215.18.65/30 dev eth1
ip link set eth1 up
ip addr flush dev eth2
ip addr add 192.215.20.137/30 dev eth2
ip link set eth2 up
ip addr flush dev eth3
ip addr add 192.215.12.17/29 dev eth3
ip link set eth3 up
ip route replace default via 192.215.24.129
ip route replace 192.215.16.0/22 via 192.215.18.66
ip route replace 192.215.20.0/22 via 192.215.20.138
ip route replace 192.215.0.0/22 via 192.215.12.18
ip route replace 192.215.4.0/22 via 192.215.12.19
ip route replace 192.215.8.0/21 via 192.215.12.20
echo 1 > /proc/sys/net/ipv4/ip_forward

echo "== Selesai: Wired =="
ip -4 addr; ip route
