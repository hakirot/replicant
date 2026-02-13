#!/usr/bin/env bash
socat -,raw,echo=0 unix-connect:/tmp/packer-qemu-monitor.sock

#info block
#  virtio0: /tmp/packer12345.qcow2
#snapshot_blkdev virtio0 debug-snapshot.qcow3

#qemu-img info debug-snapshot.qcow3

qemu-system-x86_64 \
  -m 4096 \
  -enable-kvm \
  -drive file=debug-snapshot.qcow3,if=virtio \
  -nic user,hostfwd=tcp::2222-:22

#ssh -p 2222 root@localhost

