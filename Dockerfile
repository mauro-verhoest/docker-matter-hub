#https://project-chip.github.io/connectedhomeip-doc/guides/BUILDING.html
#https://askubuntu.com/questions/707621/official-docker-image-for-ubuntu-server
FROM nrfconnect/otbr:9185bda
MAINTAINER "Mauro Verhoest"
ENV DEBIAN_FRONTEND noninteractive
#https://betterstack.com/community/questions/how-to-use-sudo-inside-docker-container/
RUN apt-get update && apt-get install -y  git sudo



#install prerequisties Linux 
RUN apt-get  install -y git gcc g++ pkg-config libssl-dev libdbus-1-dev \
     libglib2.0-dev libavahi-client-dev ninja-build python3-venv python3-dev \
     python3-pip unzip libgirepository1.0-dev libcairo2-dev libreadline-dev
#install prerequisties rpi4 
RUN apt-get  install -y bluetooth  avahi-utils

# install bluez related packages
RUN apt-get update && apt-get install -y \
    bluez \
    dbus \
    sudo
 

#get prequisties to download chip-tool 
RUN apt-get install -y wget unzip 

WORKDIR /
#download and unzip chip-tool 
RUN wget https://github.com/nrfconnect/sdk-connectedhomeip/releases/download/v2.4.0/chip-tool-linux_aarch64.zip
RUN unzip chip-tool-linux_aarch64.zip

# setup bluetooth permissions
COPY  docker-matter-hub/bluezuser.conf /etc/dbus-1/system.d/


#disable bluetooth 
#RUN  killall -9 bluetoothd

#copy chip-tool and entrypoint.sh
#ENV DIRPATH=/home/bridge/
WORKDIR /
COPY connectedhomeip/examples/chip-tool/out/debug/chip-tool-debug /usr/bin/
#COPY docker-matter-hub/docker-entrypoint.sh /

ENTRYPOINT ["/app/etc/docker/docker_entrypoint.sh", "-l","-c"]
#entrypoint [ "/bin/bash", "-l", "-c" ]
#Set working directory
#WORKDIR /home/connectedhomeip
