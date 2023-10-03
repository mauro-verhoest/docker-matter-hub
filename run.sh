#!/bin/bash
#https://www.baeldung.com/linux/shebang
set -x
#sudo service otbr-agent stop
#https://www.baeldung.com/linux/start-script-after-another-finishes
./start.sh &
wait && ./build.sh
exit 0