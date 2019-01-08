0: /boot/config.txt at end
	dtoverlay=dwc2
1: /boot/cmdline.txt before rootwait
	modules-load=dwc2
2: /etc/rc.local before exit
	/home/pi/usbgadget.sh &
3: copy script into /home/pi
	sudo cp usbgadget.sh /home/pi
4: create getty service for ttyGS0
	sudo ln -s /lib/systemd/system/getty@.service /lib/systemd/system/getty@ttyGS0.service
5: install dhcp server
	sudo apt install isc-dhcp-server

	0. /etc/default/isc-dhcp-server
		INTERFACESv4="usb0"
	1. /etc/dhcpcd.conf
		interface usb0
		static ip_address=192.168.2.1/24
	2. /etc/dhcp/dhcpd.conf
		subnet 192.168.2.0 netmask 255.255.255.0 {
			range 192.168.2.100 192.168.2.200;
			option routers 192.168.2.1;
			option subnet-mask 255.255.255.0;
			option broadcast-address 192.168.2.255;
			option domain-name-servers 192.168.2.1;
		}