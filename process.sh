#!/bin/bash

## ps
## process와 관련된 주요지표들을 표시
## 버전마다 표시되는 정보에 차이가 존재

ps aux
ps alx # 실행중인 모든 프로세스를 표시
ps aux | grep ksmd # 특정 프로세스를 search
ps aux | grep sshd # 특정 프로세스를 search
ps auxf # 트리형태

## 프로세스 종료
kill -9 [process_id] ## 무조건 종료 (kernel 수준에서 종료) => 강제종료
kill -15 [process_id] ## 우아하게 종료 (Recommand)
