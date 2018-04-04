#!/bin/bash

apt-get update && apt-get upgrade -y
apt-get update && apt-get install -y libtbb-dev libsnmp-dev binutils-dev \
                                     maven ant git oracle-java8-jdk

# Proxy setting
REGEX_PATTERN="^.\+://\(.\+\)\(:\([0-9]\+\)\)/\?$"

if [ -n "$http_proxy" ]; then
  PROXY_HOST=`echo $http_proxy | sed -e "s|$REGEX_PATTERN|\1|"`
  PROXY_PORT=`echo $http_proxy | sed -e "s|$REGEX_PATTERN|\3|"`

  export MAVEN_OPTS="$MAVEN_OPTS -Dhttp.proxyHost=$PROXY_HOST -Dhttp.proxyPort=$PROXY_PORT"
fi

if [ -n "$https_proxy" ]; then
  PROXY_HOST=`echo $https_proxy | sed -e "s|$REGEX_PATTERN|\1|"`
  PROXY_PORT=`echo $https_proxy | sed -e "s|$REGEX_PATTERN|\3|"`

  export MAVEN_OPTS="$MAVEN_OPTS -Dhttps.proxyHost=$PROXY_HOST -Dhttps.proxyPort=$PROXY_PORT"
fi

# Clone heapstats repo from GitHub
git clone https://github.com/HeapStats/heapstats.git

# Avoid JIT compiler issue
# https://bugs.launchpad.net/raspbian/+bug/1732556
export _JAVA_OPTIONS=-Xint

# Build HeapStats
cd heapstats
./configure --with-jdk=`realpath /usr/lib/jvm/jdk-8-oracle-*`
make agent
