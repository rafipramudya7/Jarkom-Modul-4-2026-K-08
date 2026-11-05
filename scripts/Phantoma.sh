
cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.215.21.162
    netmask 255.255.255.252
    up ip route add default via 192.215.21.161

auto eth1
iface eth1 inet static
    address 192.215.21.129
    netmask 255.255.255.224

auto eth2
iface eth2 inet static
    address 192.215.21.165
    netmask 255.255.255.252
    up ip route add 192.215.21.192/26 via 192.215.21.166
    up echo 1 > /proc/sys/net/ipv4/ip_forward

EOF

ip addr flush dev eth0
ip addr add 192.215.21.162/30 dev eth0
ip link set eth0 up
ip addr flush dev eth1
ip addr add 192.215.21.129/27 dev eth1
ip link set eth1 up
ip addr flush dev eth2
ip addr add 192.215.21.165/30 dev eth2
ip link set eth2 up
ip route replace default via 192.215.21.161
ip route replace 192.215.21.192/26 via 192.215.21.166
echo 1 > /proc/sys/net/ipv4/ip_forward

echo "== Selesai: Phantoma =="
ip -4 addr; ip route
