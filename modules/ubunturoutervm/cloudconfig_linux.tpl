#cloud-config
package_upgrade: true
packages:
  - traceroute
runcmd:
  - sysctl -w net.ipv4.ip_forward=1
  - sysctl -w net.ipv6.conf.all.forwarding=1
  - sed -i "/net.ipv4.ip_forward=1/ s/# *//" /etc/sysctl.conf
  - iptables -t nat -A POSTROUTING -d 10.0.0.0/8 -j ACCEPT
  - iptables -t nat -A POSTROUTING -d 172.16.0.0/12 -j ACCEPT
  - iptables -t nat -A POSTROUTING -d 192.168.0.0/16 -j ACCEPT
  - iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
ntp:
  pools: ['0.de.pool.ntp.org', '1.de.pool.ntp.org', '2.de.pool.ntp.org', '3.de.pool.ntp.org']