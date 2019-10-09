#!/bin/bash

# Proxy setting
source /root/maven-proxy.sh

# Update & Install
apt-get update && apt-get upgrade -y
apt-get install -y libtbb-dev libsnmp-dev binutils-dev \
                   maven ant openjdk-11-jdk

# Build HeapStats
cd /root/heapstats
./configure --with-jdk=/usr/lib/jvm/java-11-openjdk-armhf
make agent
