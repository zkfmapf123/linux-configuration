#!/bin/sh

## df 디스크 여유용량 확인
df 

## 용량 쉽게
df -h

## 현재위치
df . 

## du 디렉토리별 공간 확인
du 
du -a # 파일 0 인것까지 모두 확인

du -s   # 지정한 디렉토리 내에 존재하는 파일 및 디렉토리의 합
du -h   # 결과 내용을 가독성있게 표시
du -d 1 # 1 depth 디렉토리 까지 용량 확인

## 홈 디렉토리 정보 조회
du -sh /home/ubuntu

## Depth1로 홈 디렉토리 사용량 정보 조회
du -h -d 1 /home/ubuntu

## 홈 디렉토리 사용량 조회결과를 크기 역순으로 정렬
du -h -d 1 /home/ubuntu | sort -h -r

## 디스크를 가장많이 사용하고 있는 디렉토리 정보
du -h -d 1 / 2> /dev/null | sort -h -r | head -n 20
du -h -d 1 /usr 2> /dev/null | sort -h -r | head -n 20