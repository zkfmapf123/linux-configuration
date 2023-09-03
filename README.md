# Linux Configuration

## Execute

```
    cd infra && terraform init && terraform apply
```

## Bios의 시스템 정보읽기

```
    dmidecode -t memory
```

## systemd

```
    cd /etc/systemd
```

> 특징

    - 기존 init 프로세스의 기능을 지원 및 통합
    - systemd에 등록된 프로세스는 병렬처리 및 종속성 모델 관리
    - Management use Kernel log entry (journald)
    - Management use Connection network (netword)
    - Management use Login (logind)

> Unit

    - unit 별로 정의
    - service를 사용
    - ini 파일로 관리가 됨
        ```
            - Description : Unit 정보
            - After, Requires, Wants : Unit 종속성 관리
            - ExecStart : 구동할 명령어 지정 (절대경로)
            - Restart : 서비스 재시작 여부 지정
            - Alais : Unit을 등록할때 사용하는 이름 (systemd enable sshd.service)
            - WantedBy : Unit간 종속성 지정
        ```

> systemd 관리용 도구 "systemctl"

    ```
        ## active 상태의 서비스 확인
        systemctl list-units --type=service

        ## 모든 설치된 서비스 확인
        systemctl list-unit-files --type=service
    ```

> unit 간의 의존성

    ```
        ## docker.service
        ...
        [Unit]
        Description=Docker Application Container Engine
        Documentation=https://docs.docker.com
        After=network-online.target filewalld.service containerd.service // docker.service 실행 후에 실행되는 서비스
        Wants=network-online.target // 가능하다면 함께 실행이 필요함 (강제 아님)
        Requires=docker.socket containerd.service // 강제로 함께 실행이 필요함
        ...
    ```

> Example

```sh
    cd /etc/systemd/system/uptime-logger.service

    cd /usr/local/bin/uptime-logger

    sudo systemctl enable uptime-logger.service
    sudo systemctl start uptime-logger.service
    sudo systemctl status uptime-logger.service

    tail -f /tmp/uptime.log
```

## Linux Process 관리

> Linux Process

- Linux에서는 프로세스를 새로 만들지 않음
- 기존 프로세스를 복제 및 프로그램을 교체하는 방식으로 운용

  1. 기존 프로세스는 새로운 프로세스를 생성하고 -> 자신을 복제
  2. 복제된 프로세스는 현재 실행중인 프로그램을 교체

  ```sh
      pstree -p
  ```

> Linux Process 우선순위

- process.sh
- 우선순위가 높다는 것은 => CPU 사용시간이 많다 (-20 ~ +19)
- CPU 성능 상 굳이 우선순위를 변경하지 않음 (대부분 기본값을 사용)
- CPU 스케쥴링이 알아서 관리

  ```sh

    ## 우선순위
    ps ax -o pid,ni,cmd
  ```

> proc

- 보통 프로세스나, CPU, MEM 정보는 Kernel단에 정보임
- Usermode 단에서 해당 자원들을 읽을 수 있게하는 Directory
  ```
      cd /proc
      cat cpuinfo
  ```

## Linux CronJob + logrotated

- n시 마다 보안관련도구 실행
- 백업 및 미러링
- 배치 작업 수행
- 시스템정보를 메일로 전송(주기적) \*\*\* => 추후 진행해보자
- 로그데이터 관리
- 일정기간동안의 로그데이터는 압축 -> 그 후에는 삭제 \*\*\* => 추후 진행해보자

> cron

- cron 작업은 systemd로 관리 -> 계속 실행이 됨

```
    crontab -e // crontab 항목 편집
    crontab -l // crontab 리스트 출력
    crontab -r // crontab 삭제

    crontab -e
    * * * * * echo "hello world" >> /tmp/hello_world
    tail -f /tmp/hello_world
```

- <a href="https://crontab.guru/"> Cron Maker </a>
- <a href="https://stackoverflow.com/questions/5952467/how-to-specify-a-editor-to-open-crontab-file-export-editor-vi-does-not-work"> Crontab use vi editor </a>
