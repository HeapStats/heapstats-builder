#!/bin/sh

# Set variables
export MAJOR=`echo $RELEASE | sed -e 's/^\([0-9]\+\.[0-9]\+\)\.[0-9]\+$/\1/'`
export RELEASE_DIR=heapstats-$RELEASE
export OUTDIR=/share/$RELEASE_DIR

if [ -z "$BZ2_ARCHIVE" ]; then
  BZ2_ARCHIVE=https://icedtea.classpath.org/hg/release/heapstats-$MAJOR/archive/$RELEASE.tar.bz2
fi

# Download source archive
wget -q -O - $BZ2_ARCHIVE | tar jx

# Rename top dir to "heapstats-<major number>" format
mv -f heapstats* heapstats-$MAJOR

# Re-archive to tar-ball to build via rpmbuild
tar cfz $RELEASE_DIR.tar.gz heapstats-$MAJOR
