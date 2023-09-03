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
