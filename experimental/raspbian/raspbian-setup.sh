#!/bin/sh

OPT1=$1
OPT2=$2
if [ "$OPT1" = "--skip-mount" ]; then
  SKIP_MOUNT=1
  VER=$OPT2
else
  SKIP_MOUNT=0
  VER=$OPT1
fi

export LANG=C
export SYSROOT=rpi_sysroot

if [ "$VER" != "2.0" ] && [ "$VER" != "2.1" ]; then
  VER=trunk
fi

pushd $(cd `dirname $0` && pwd)


if [ $SKIP_MOUNT -eq 0 ]; then
  ./mount.sh
fi

# Cancel ld.so.preload
mv $SYSROOT/etc/ld.so.preload $SYSROOT/etc/ld.so.preload.bak

# Clone from HeapStats repo
if [ $VER = "2.0" ] || [ "$VER" = "2.1" ]; then
  if [ ! -d $SYSROOT/root/heapstats-$VER ]; then
    hg clone http://icedtea.classpath.org/hg/release/heapstats-$VER $SYSROOT/root/heapstats-$VER
  fi
else
  if [ -n "$LOCAL_GZ_ARCHIVE" ]; then
    tar xvfz $LOCAL_GZ_ARCHIVE -C $SYSROOT/root/
    mv $SYSROOT/root/heapstats* $SYSROOT/root/heapstats
  elif [ ! -d $SYSROOT/root/heapstats ]; then
    hg clone http://icedtea.classpath.org/hg/heapstats $SYSROOT/root/heapstats
  fi
fi

# Run builder
ARG="-D $SYSROOT"
if [ -n "$http_proxy" ]; then
  ARG="$ARG -E http_proxy=$http_proxy"
fi
if [ -n "$https_proxy" ]; then
  ARG="$ARG -E https_proxy=$https_proxy"
fi

systemd-nspawn $ARG /root/build.sh $VER

# Recover ld.so.preload
mv $SYSROOT/etc/ld.so.preload.bak $SYSROOT/etc/ld.so.preload

popd
