
cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
    address 192.215.24.1
    netmask 255.255.255.128

auto eth2
iface eth2 inet static
    address 192.215.24.129
    netmask 255.255.255.252
    up ip route add 192.215.0.0/20 via 192.215.24.130
    up ip route add 192.215.16.0/21 via 192.215.24.130
    up echo 1 > /proc/sys/net/ipv4/ip_forward

EOF

ip link set eth0 up  
ip addr flush dev eth1
ip addr add 192.215.24.1/25 dev eth1
ip link set eth1 up
ip addr flush dev eth2
ip addr add 192.215.24.129/30 dev eth2
ip link set eth2 up
ip route replace 192.215.0.0/20 via 192.215.24.130
ip route replace 192.215.16.0/21 via 192.215.24.130
echo 1 > /proc/sys/net/ipv4/ip_forward

command -v iptables >/dev/null && (iptables -t nat -C POSTROUTING -o eth0 -j MASQUERADE 2>/dev/null || iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE)

echo "== Selesai: Cyberia =="
ip -4 addr; ip route
