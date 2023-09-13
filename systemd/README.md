# Systemd

## Desc

- 시작 서비스
- 시스템 구동 시 최초로 실행되는 사용자 레벨 프로세스 (pid 1)
- 부팅 후에도 서비스가 구동되도록 하는 Linux System === Windows Deamon

## Exec

```sh
    ## 서비스 파일
    ## /etc/systemd/system/~.service

    ## 서비스 목록 리로드
    sudo systemctl daemon-reload

    ## Service 추가
    sudo systemctl start uptime-logger.service
    sudo systemctl enable uptime-logger.service

    ## 시스템 재시작 서비스 상태 확인
    sudo systemctl status uptime-logger.service

```

- Bios Hardward 보기

```sh
    dmidecode
```

## Reference

- <a href="https://junb51.tistory.com/9">systemd property</a>
