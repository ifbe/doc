0: copy script into /home/pi
	sudo cp usbgadget.sh /home/pi
1: create getty service for ttyGS0
	sudo ln -s /lib/systemd/system/getty@.service /lib/systemd/system/getty@ttyGS0.service
2: install dhcp server
	sudo apt install isc-dhcp-server
3: manually add this in /etc/rc.local before exit
	/home/pi/usbgadget.sh &
