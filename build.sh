#!/bin/sh
#https://www.baeldung.com/linux/shebang
set -x
cd ~/
#https://docs.docker.com/engine/reference/commandline/build/
docker build --platform=linux/arm/v8  -f docker-matter-hub/Dockerfile -t matter-hub . 
