#!/bin/sh

while :
do
    echo $(/bin/date) - $(/usr/bin/uptime) >> /tmp/uptime.log
    sleep 5
done