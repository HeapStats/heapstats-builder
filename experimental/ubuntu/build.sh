#!/bin/bash

# Proxy setting
source maven-proxy.sh

# Clone HeapStats repo from GitHub
git clone https://github.com/HeapStats/heapstats.git

# Make HeapStats
cd heapstats
./configure --with-jdk=/usr/lib/jvm/java-13-openjdk-amd64
make
