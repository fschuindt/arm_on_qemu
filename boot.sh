#!/usr/bin/env bash

eval $(cat config.env)

qemu-system-arm \
  -kernel raspbian_bootpart/kernel-qemu-4.14.79-stretch \
  -dtb raspbian_bootpart/versatile-pb.dtb \
  -m 256 -M versatilepb -cpu arm1176 \
  -serial stdio \
  -append "rw console=ttyAMA0 root=/dev/sda2 rootfstype=ext4  loglevel=8 rootwait fsck.repair=yes memtest=1" \
  -drive file=2018-11-13-raspbian-stretch-lite.img,format=raw \
  -device e1000,netdev=net0 \
  -netdev user,id=net0,hostfwd=tcp::5555-:22 \
  -virtfs local,path=$MOUNT_HOST_PATH,mount_tag=host0,security_model=passthrough,id=host0 \
  -no-reboot

export MOUNT_HOST_PATH=

