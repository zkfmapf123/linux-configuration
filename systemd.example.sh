#!/bin/bash

## 현재 서비스 중인 systemctl
systemctl list-units --type=service

## cron 서비스 현재 상황
systemctl status cron.service

##
# cron.service의 경우 Restart=on-failure 가 설정되어 있음
##

## Before
ps aux | grep cron

## After
# sudo kill -9 [cron-pid]
ps aux | grep cron

## Restart After
systemctl restart cron.service
ps aux | grep cron
