#!/bin/sh
#https://www.baeldung.com/linux/shebang
sudo modprobe ip6table_filter
docker-compose run -d 