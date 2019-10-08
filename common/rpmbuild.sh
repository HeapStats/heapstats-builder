#!/bin/bash

# Setup
source setup.sh
source maven-proxy.sh

[ ! -d $OUTDIR/bin/agent ] && mkdir -p $OUTDIR/bin/agent
[ ! -d $OUTDIR/bin/analyzer ] && mkdir -p $OUTDIR/bin/analyzer

# Make RPM
mkdir -p ~/rpmbuild/SOURCES ~/rpmbuild/SPECS

cp $OUTDIR/src/$RELEASE_DIR.tar.gz ~/rpmbuild/SOURCES/
cp heapstats-$MAJOR/specs/heapstats.spec ~/rpmbuild/SPECS
rpmbuild -ba ~/rpmbuild/SPECS/heapstats.spec

# Deploy RPMs
cp -f ~/rpmbuild/RPMS/x86_64/* $OUTDIR/bin/agent/
cp -f ~/rpmbuild/SRPMS/* $OUTDIR/src/
[ -d ~/rpmbuild/RPMS/noarch ] && cp -f ~/rpmbuild/RPMS/noarch/* $OUTDIR/bin/analyzer/
