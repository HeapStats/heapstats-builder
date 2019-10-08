#!/bin/bash

# Proxy setup
REGEX_PATTERN="^.\+://\(\(.\+\):\(.\+\)@\)\?\(.\+\)\(:\([0-9]\+\)\)/\?$"

if [ -n "$http_proxy" ]; then
  PROXY_USER=`echo $http_proxy | sed -e "s|$REGEX_PATTERN|\2|"`
  PROXY_PASS=`echo $http_proxy | sed -e "s|$REGEX_PATTERN|\3|"`
  PROXY_HOST=`echo $http_proxy | sed -e "s|$REGEX_PATTERN|\4|"`
  PROXY_PORT=`echo $http_proxy | sed -e "s|$REGEX_PATTERN|\6|"`

  export MAVEN_OPTS="$MAVEN_OPTS -Dhttp.proxyHost=$PROXY_HOST -Dhttp.proxyPort=$PROXY_PORT"

  if [ -n "$PROXY_USER" ]; then
    export MAVEN_OPTS="$MAVEN_OPTS -Dhttp.proxyUser=$PROXY_USER -Dhttp.proxyPassword=$PROXY_PASS"
  fi

fi

if [ -n "$https_proxy" ]; then
  PROXY_USER=`echo $https_proxy | sed -e "s|$REGEX_PATTERN|\2|"`
  PROXY_PASS=`echo $https_proxy | sed -e "s|$REGEX_PATTERN|\3|"`
  PROXY_HOST=`echo $https_proxy | sed -e "s|$REGEX_PATTERN|\4|"`
  PROXY_PORT=`echo $https_proxy | sed -e "s|$REGEX_PATTERN|\6|"`

  export MAVEN_OPTS="$MAVEN_OPTS -Dhttps.proxyHost=$PROXY_HOST -Dhttps.proxyPort=$PROXY_PORT"

  if [ -n "$PROXY_USER" ]; then
    export MAVEN_OPTS="$MAVEN_OPTS -Dhttps.proxyUser=$PROXY_USER -Dhttps.proxyPassword=$PROXY_PASS"
  fi

fi
