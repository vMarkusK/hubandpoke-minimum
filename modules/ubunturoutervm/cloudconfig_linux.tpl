#cloud-config
package_upgrade: true
packages:
  - traceroute
runcmd:
  - sudo sysctl -w net.ipv4.ip_forward=1
ntp:
  pools: ['0.de.pool.ntp.org', '1.de.pool.ntp.org', '2.de.pool.ntp.org', '3.de.pool.ntp.org']