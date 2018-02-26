#!/bin/sh

RELEASE_DIR=heapstats-$RELEASE
OUTDIR=/share/$RELEASE_DIR


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

# Extract source archive
tar xvfz $OUTDIR/src/$RELEASE_DIR.tar.gz

# Make RPM
mkdir -p ~/rpmbuild/SOURCES ~/rpmbuild/SPECS
cp $OUTDIR/src/$RELEASE_DIR.tar.gz ~/rpmbuild/SOURCES
cp heapstats-$MAJOR/specs/heapstats.spec ~/rpmbuild/SPECS
rpmbuild -ba ~/rpmbuild/SPECS/heapstats.spec
cp -f ~/rpmbuild/RPMS/x86_64/* $OUTDIR/bin/agent/
cp -f ~/rpmbuild/RPMS/noarch/* $OUTDIR/bin/analyzer/
cp -f ~/rpmbuild/SRPMS/* $OUTDIR/src/

