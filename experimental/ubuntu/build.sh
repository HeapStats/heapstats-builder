#!/bin/sh

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

# Clone HeapStats repo from GitHub
git clone https://github.com/HeapStats/heapstats.git

# Make HeapStats
cd heapstats
./configure
make

