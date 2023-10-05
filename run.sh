#!/bin/bash
#https://www.baeldung.com/linux/shebang
set -x
#sudo service otbr-agent stop
#https://www.baeldung.com/linux/start-script-after-another-finishes

./build.sh
./start.sh
exit 