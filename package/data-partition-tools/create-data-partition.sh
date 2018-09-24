#!/bin/bash

DEVICE=/dev/mmcblk0
PARTITION=/dev/mmcblk0p3

# First we need to create the partition if it's missing.
if [ ! -b $PARTITION ]; then
    sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk ${DEVICE}
  n # new partition
  p # primary partition
  3 # partition number 3
    # default - start at beginning of disk
    # default - remainder of disk
  p # print the in-memory partition table
  w # write the partition table
  q # and we're done
EOF
    reboot
    exit 0
fi

# Check to see if the partition is valid and create a file system if we need to.
if ! blkid $PARTITION | grep ext4; then
    mkfs.ext4 $PARTITION
fi

# Now test to see if the device is already mounted and mount if necessary.
if ! mount | grep $PARTITION; then
    mkdir -p /data
    mount $PARTITION /data
fi
