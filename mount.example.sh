#!/bin/bash

## tmpfs 특수목적을 가진 디스크를 변경할 거야
df -h 

mkdir /tmp/test_mount

sudo mount -t tmpfs none /tmp/test_mount
sudo umount /tmp/test_mount