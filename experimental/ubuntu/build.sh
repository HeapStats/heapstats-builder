#!/bin/bash

# Proxy setting
source maven-proxy.sh

if [ -n "$LOCAL_GZ_ARCHIVE" ]; then
  tar xvfz archive/$LOCAL_GZ_ARCHIVE
else
  if [ "$VER" != "2.0" ] && [ "$VER" != "2.1" ]; then
    VER=trunk
  fi

  # Clone from HeapStats repo
  if [ "$VER" = trunk ]; then
    hg clone http://icedtea.classpath.org/hg/heapstats
  else
    hg clone http://icedtea.classpath.org/hg/release/heapstats-$VER
  fi
fi

# Make HeapStats
cd heapstats*

if [ "$VER" = "2.0" ] || [ "$VER" = "2.1" ]; then
  export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
  ./configure
  make agent
  # Ubuntu eoan does not provide OpenJFX 8.
  # So we cannot build FXAnzlyzer on eoan.
  #   https://packages.ubuntu.com/de/eoan/openjfx
  mvn -pl analyzer/cli -am package
else
  apt-get install -y openjdk-13-jdk
  ./configure --with-jdk=/usr/lib/jvm/java-13-openjdk-amd64
  make
fi
