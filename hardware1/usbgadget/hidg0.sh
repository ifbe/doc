if [ ! -n "$1" ];then
echo usage: ./hidg0.sh val
else
echo -ne "\x00\x00\x13\x0c\x27\x1a\x33\x$1" > /dev/hidg0
echo -ne "\x00\x00\x00\x00\x00\x00\x00\x00" > /dev/hidg0
fi
