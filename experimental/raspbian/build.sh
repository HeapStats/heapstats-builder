#!/bin/bash

VER=$1

# Proxy setting
source /root/maven-proxy.sh

# Update & Install
apt-get update && apt-get upgrade -y
apt-get install -y libtbb-dev libsnmp-dev binutils-dev \
                   maven ant openjdk-8-jdk

# Build HeapStats
if [ "$VER" = "trunk" ]; then
  cd /root/heapstats
else
  cd /root/heapstats-$VER
fi
./configure --with-jdk=/usr/lib/jvm/java-8-openjdk-armhf
make agent
