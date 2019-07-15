git clone https://github.com/openwrt/openwrt
cd openwrt
./scripts/feeds update -a
./scripts/feeds install -a

vi target/linux/ar71xx/image/tiny-tp-link.mk
	#4m -> 8m
vi target/linux/ath79/image/tiny-tp-link.mk
	#4m -> 8m

make defconfig
make clean
make menuconfig
	#select ar71xx
	#select tiny
	#select wr703n
	#select luci, ssl, chinese
