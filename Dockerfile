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
RUN apt-get  install -y bluetooth avahi-utils

RUN pip3 install bluepy
RUN pip3 install git+https://github.com/don41382/magicblue

# install wiringPI
RUN git clone git://git.drhogon.net/wiringPi
RUN cd wiringPi && ./build

RUN pip3 install pi_switch

# fix library problem for python3 & libboost
RUN mv /usr/lib/arm-linux-gnueabihf/libboost_python-py27.so.1.55.0 /usr/lib/arm-linux-gnueabihf/libboost_python-py27.so.1.55.0-old
RUN ln -s /usr/lib/arm-linux-gnueabihf/libboost_python-py34.so.1.55.0 /usr/lib/arm-linux-gnueabihf/libboost_python-py27.so.1.55.0


#get prequisties to download chip-tool 
RUN apt-get install -y wget unzip 

#download and unzip chip-tool 
RUN wget https://github.com/nrfconnect/sdk-connectedhomeip/releases/download/v2.4.0/chip-tool-linux_aarch64.zip
RUN unzip chip-tool-linux_aarch64.zip


#disable bluetooth 
#RUN  killall -9 bluetoothd

#copy chip-tool and entrypoint.sh
#ENV DIRPATH=/home/bridge/
WORKDIR /
COPY connectedhomeip/examples/chip-tool/out/debug/chip-tool-debug /usr/bin/
COPY connectedhomeip/examples/chip-tool/entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh", "tool"]
#entrypoint [ "/bin/bash", "-l", "-c" ]
#Set working directory
#WORKDIR /home/connectedhomeip
