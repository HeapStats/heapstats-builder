#!/bin/sh

RELEASE_DIR=heapstats-$RELEASE

wget $BZ2_ARCHIVE
tar xvf *.bz2
mv -f heapstats* heapstats-$MAJOR
tar cvfz $RELEASE_DIR.tar.gz heapstats-$MAJOR


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

# Make output directory
OUTDIR=/share/$RELEASE_DIR
mkdir -p $OUTDIR/bin/agent $OUTDIR/bin/analyzer $OUTDIR/src

# Deploy source archive
cp $RELEASE_DIR.tar.gz $OUTDIR/src

# Make Analyzer ZIP binary
cd heapstats-$MAJOR
./configure
make analyzer

# Deploy Analyzer ZIP binary
cp analyzer/fx/target/heapstats-analyzer-*.zip $OUTDIR/bin/analyzer/
cp analyzer/cli/target/heapstats-cli-*.zip $OUTDIR/bin/analyzer/

# Deploy Analyzer API
if [ -d analyzer/plugin-api ]; then
  mkdir $OUTDIR/api
  cp analyzer/core/target/heapstats-core-*.jar $OUTDIR/api/
  cp analyzer/plugin-api/target/heapstats-plugin-api-*.jar $OUTDIR/api/
fi

