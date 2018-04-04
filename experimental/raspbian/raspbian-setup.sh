#!/bin/sh

export LANG=C

# Get Raspbian
wget -O raspbian.zip https://downloads.raspberrypi.org/raspbian_lite_latest
unzip raspbian.zip
IMAGE=`basename *.img`

# Calculate offset
SECTOR_SIZE=`fdisk -l $IMAGE | grep -E '^Units:' | sed -e 's/^.\+= \([0-9]\+\) bytes$/\1/'`
START_SECTOR=`fdisk -l $IMAGE | grep img2 | tr -s '[[:space:]]' ',' | cut -d',' -f 2`
OFFSET=`expr $SECTOR_SIZE \* $START_SECTOR`

# Mount
mkdir rpi_sysroot
mount -o offset=$OFFSET $IMAGE rpi_sysroot
cp build.sh rpi_sysroot/root/build.sh

# Run builder
ARG='-D rpi_sysroot'
if [ -n "$http_proxy" ]; then
  ARG="$ARG -E http_proxy=$http_proxy"
fi
if [ -n "$https_proxy" ]; then
  ARG="$ARG -E https_proxy=$https_proxy"
fi

systemd-nspawn $ARG /root/build.sh
