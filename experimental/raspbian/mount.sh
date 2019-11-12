#!/bin/sh

# Get Raspbian
wget -O raspbian.zip https://downloads.raspberrypi.org/raspbian_lite_latest
unzip raspbian.zip
IMAGE=`basename *.img`

# Calculate offset
SECTOR_SIZE=`fdisk -l $IMAGE | grep -E '^Units:' | sed -e 's/^.\+= \([0-9]\+\) bytes$/\1/'`
START_SECTOR=`fdisk -l $IMAGE | grep img2 | tr -s '[[:space:]]' ',' | cut -d',' -f 2`
OFFSET=`expr $SECTOR_SIZE \* $START_SECTOR`

# Resize image
qemu-img resize -f raw $IMAGE +1G

# Resize partition
fdisk $IMAGE <<EOF
d
2
n
p
2
$START_SECTOR

w
EOF

# Mount
mkdir $SYSROOT
mount -o offset=$OFFSET $IMAGE $SYSROOT

# Resize filesystem
LOOPBACK_DEV=`df | grep rpi_sysroot | cut -d' ' -f 1`
resize2fs $LOOPBACK_DEV

cp build.sh maven-proxy.sh $SYSROOT/root/
