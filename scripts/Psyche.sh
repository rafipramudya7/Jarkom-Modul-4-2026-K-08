
cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.215.12.18
    netmask 255.255.255.248
    up ip route add default via 192.215.12.17

auto eth1
iface eth1 inet static
    address 192.215.0.1
    netmask 255.255.252.0
    up echo 1 > /proc/sys/net/ipv4/ip_forward

EOF

ip addr flush dev eth0
ip addr add 192.215.12.18/29 dev eth0
ip link set eth0 up
ip addr flush dev eth1
ip addr add 192.215.0.1/22 dev eth1
ip link set eth1 up
ip route replace default via 192.215.12.17
echo 1 > /proc/sys/net/ipv4/ip_forward

echo "== Selesai: Psyche =="
ip -4 addr; ip route
