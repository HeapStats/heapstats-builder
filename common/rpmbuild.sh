#!/bin/bash

# Setup
source setup.sh
source maven-proxy.sh

# Make RPM
mkdir -p ~/rpmbuild/SOURCES ~/rpmbuild/SPECS

cp $OUTDIR/src/$RELEASE_DIR.tar.gz ~/rpmbuild/SOURCES/
cp heapstats-$MAJOR/specs/heapstats.spec ~/rpmbuild/SPECS
rpmbuild -ba ~/rpmbuild/SPECS/heapstats.spec

# Deploy RPMs
[ ! -d $OUTDIR/bin/agent ] && mkdir -p $OUTDIR/bin/agent
cp -f ~/rpmbuild/RPMS/x86_64/* $OUTDIR/bin/agent/
cp -f ~/rpmbuild/SRPMS/* $OUTDIR/src/

if [ -d ~/rpmbuild/RPMS/noarch ]; then
  [ ! -d $OUTDIR/bin/analyzer ] && mkdir -p $OUTDIR/bin/analyzer
  cp -f ~/rpmbuild/RPMS/noarch/* $OUTDIR/bin/analyzer/
fi
