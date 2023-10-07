#!/bin/bash

today=`date +%Y_%m_%d_%H-%M-%S`
echo $today

tar cvfJ ./backup/"backup.$today.xz" /etc/systemd/