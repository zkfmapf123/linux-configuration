# Logging

## Desc

    - PLog를 수집
    - System deamon, Kernel, Application Log들을 다양하게 수집
    - 로그를 검색하기 위한 다양한 방법이 필요 -> Elastic Search
    - 메시지 유지 및 만료 관리 -> 적절한 로그 사이즈 및 삭제관리 (수명주기)

## 로그 관리 정책 필요

    - 로그 종류별로 유용한 수명이 한정되어 있음

## syslog

    - 전통적인 리눅스의 로그들은 여기에 다있음
    - 하지만.... 자신의 로그파일에 로그를 저장함

## journalctl \*\*\*

![journal](./journalctl)

    - Desc
        - journal을 사용해서 로그통합을 위해 좀더 개선된 방법으로 로그관리 방식을 제공
        - 메시지를 효율적으로 저장 및 검색 지원 (인덱싱)
        - 압축된 바이너리 형태로 로그메시지를 저장 (압축)
        - 로그를 보거나 필터링하는 cmd 사용할 수 있음

    - alias 등록

        ```sh
            sudo vi ~/.bashrc

            # .bashrc

            alias jctl='journalctl'

            # Source global definitions

            if [ -f /etc/bashrc ]; then
            . /etc/bashrc
            fi
        ```

    - alias

        ```sh
            alias
        ```

    - journald의 중요한 옵션
        - storage (auto) => 데이터는 디스크에 저장 (재시작해도 로그유지)
        - storage (volatile) => 저널을 메모리에 저장
        - storage (persistent) => 저널을 /var/log/journal 디렉토리에 로그 저장, 디렉토리가 없는 경우 새로 생성
        - 로그가 유실되지 않도록 속도제한
            - RateLimitIntervalSec=30s (서비스 별 30초당)
            - RateLimitBurst=10000 (10,000 메시지)

## 로그파일관리

![nginx_logrotate](./nginx_lotate)

- 복잡한 로그관리 직접할 필요없음 -> logrotate
- 다양한 관리정책이 존재
- 주요 옵션

```text
    compress                       현재버전이 아닌 log파일들을 압축
    daily, weekly, monthly         지정된 일정대로 로그파일들을 로테이션
    delaycompress                  현재와 가장 최근버전을 제외한 모든버전을 압축

    missingok                      로그파일이 존재하지 않는 경우에 오류처리하지 않음
    notifempty                     로그파일이 비어있으면 로테이트 하지 않음
    copytruncate                   로그데이터를 새로운 파일로 카피하고, 기존파일을 비움 **

    postrotate                     로그 로테이션이 완료된 후에 실행될 스크립트
    rotate n                       최대 n개 버전의 로그파일을 유지
    size logsize                   로그파일이 logsize 크기를 넘어선 경우 로테이션

    ## 설정파일 위치
    /etc/logrotate.conf
    /etc/logrotate.d/디렉토리 ## cron에 의해 매일 1회 수정
```

## 대규모 로그 관리

- 서비스의 규모가 커짐에 따라 서버에 직접 접속해서 로그를 확인하는 것은 어려워짐
- 여러가지 오픈소스 도구 및 Saas 서비스들이 존재
- ELK 스택 => 요청이 많을 경우 Buffer Layer (RabbitMQ, AWS SQS, Kafka) 구성이 필요
- 서비스형 => Datadog, CloudWatch Logs(비쌈...)

## Reference

- <a href="https://server-talk.tistory.com/459"> journalctl 명령어 </a>
