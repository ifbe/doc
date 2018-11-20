#!/bin/bash

# 1. use ifconfig to get the network interface card name, like enx000XXXX
# 2. set ip for that NIC `ifconfig enx000XXXX 192.168.200.1`
# 3. `dnsmasq -C dnsmasq.conf`
# 4. sometimes it needs to kill other dnsmasq first before step3.
#     `ps -elf|grep dnsmasq|awk '{print $4}'|xargs kill -9`
# 5. for some Linux distribution, it also needs to disable NetworkManager to prevent it from mangling the assigned IP address.
#     `service NetworkManager stop` or `systemctl stop NetworkManager`


cat > dnsmasq.conf << "EOL"
#reference: https://chromium.googlesource.com/chromiumos/platform/factory/+/HEAD/setup/NETBOOT.md
interface=enx000XXXX
tftp-root=/home/cdev/Documents/tftp


enable-tftp

dhcp-leasefile=/tmp/dnsmasq.lease

dhcp-range=192.168.200.10,192.168.200.100,12h
port=0
EOL
