#!/bin/sh
set -x
#https://www.baeldung.com/linux/shebang
sudo modprobe ip6table_filter
sudo docker run -it --rm --privileged --name matter-hub --network otbr -p 8080:80 --sysctl "net.ipv6.conf.all.disable_ipv6=0 net.ipv4.conf.all.forwarding=1 net.ipv6.conf.all.forwarding=1" --volume /dev/ttyACM0:/dev/radio matter-hub --radio-url spinel+hdlc+uart:///dev/radio?uart-baudrate=1000000
#sudo docker-compose up 
echo "pipi"