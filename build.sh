#!/bin/bash

#Sset -x
#https://www.baeldung.com/linux/shebang

cd ~/
#https://docs.docker.com/engine/reference/commandline/build/
docker build --platform=linux/arm/v8  -f docker-matter-hub/Dockerfile -t matter-hub . 
echo "build complete"
exit 0
