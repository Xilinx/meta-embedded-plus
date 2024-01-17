#!/bin/sh
if [ -e /sys/bus/platform/devices/rpu-channel/ready ]; then
   /usr/bin/soft-kernel-daemon
fi
