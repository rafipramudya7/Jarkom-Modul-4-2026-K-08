
cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.215.18.66
    netmask 255.255.255.252
    up ip route add default via 192.215.18.65

auto eth1
iface eth1 inet static
    address 192.215.16.1
    netmask 255.255.255.0

auto eth2
iface eth2 inet static
    address 192.215.18.1
    netmask 255.255.255.192

auto eth3
iface eth3 inet static
    address 192.215.17.1
    netmask 255.255.255.0
    up echo 1 > /proc/sys/net/ipv4/ip_forward

EOF

ip addr flush dev eth0
ip addr add 192.215.18.66/30 dev eth0
ip link set eth0 up
ip addr flush dev eth1
ip addr add 192.215.16.1/24 dev eth1
ip link set eth1 up
ip addr flush dev eth2
ip addr add 192.215.18.1/26 dev eth2
ip link set eth2 up
ip addr flush dev eth3
ip addr add 192.215.17.1/24 dev eth3
ip link set eth3 up
ip route replace default via 192.215.18.65
echo 1 > /proc/sys/net/ipv4/ip_forward

echo "== Selesai: Navi =="
ip -4 addr; ip route
