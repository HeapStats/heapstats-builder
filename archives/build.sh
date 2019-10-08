#!/bin/bash

# Setup
source setup.sh
source maven-proxy.sh

# Make Analyzer ZIP binary
cd heapstats-$MAJOR
mvn package

# Deploy Analyzer ZIP binary
[ ! -d $OUTDIR/bin/analyzer ] && mkdir -p $OUTDIR/bin/analyzer
cp analyzer/fx/target/heapstats-analyzer-*.zip $OUTDIR/bin/analyzer/
cp analyzer/cli/target/heapstats-cli-*.zip $OUTDIR/bin/analyzer/

# Deploy Analyzer API
if [ -d analyzer/plugin-api ]; then
  [ ! -d $OUTDIR/api ] && mkdir -p $OUTDIR/api
  cp analyzer/core/target/heapstats-core-*.jar $OUTDIR/api/
  cp analyzer/plugin-api/target/heapstats-plugin-api-*.jar $OUTDIR/api/
fi
