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

## FileSystem

> Disk 기반 파일 시스템

- Linux
  - EXT3, EXT4, ZFS, BTRFS
- Windows
  - FAT, NTFS
- MacOS
  - HFS, APFS

> Network File System

- 네트워크로 연결된 다른 컴퓨터의 파일시스템을 마운트로해서 사용 (EBS)
- NFS, SMB, CIFS
- EBS, EFS, ...

> 특수파일 시스템 (가상파일 시스템)

- 실제 디스크 공간을 관리하지 않음
- proc, sysfs, tmpfs, cgroup => 특수목적

> File Mount

- mount.example.sh
- 마운트 시에는 /etc/fstab에 파일 명세를 진행해야 함
  ```
      cat /etc/fstab
  ```

> Directory

```
    /                   => 기본계층
    /bin                => 명령어 바이너리 (all command)
    /sbin               => 필수 시스템 바이너리 (init, ip, mount)
    /usr/bin            => 대부분의 명령과 실행 파일

    /opt                => 선택 가능한 응용 소프트웨어 패키지
    /usr/local          => 로컬 소프트웨어나 환경설정 데이터
    /etc                => 시스템에 필수적인 싲가 및 설정파일
    /run                => 실행주인 프로그램을 위한 pid, socket을 위한 디렉토리
    /var/log            => 시스템 로그 파일

    /home               => 사용자 홈 디렉토리
    /tmp                => 재부팅 시 삭제되는 임시파일
```

> Command

- du.example.sh

```
    df      => 남은 용량
    df -h   => 읽기 편한 양식
    df .    => 현재 디렉토리 기준

    du      => 현재 디렉토리에서 하위 디렉토리까지 사용량
    du -a   => 모두 확인
    du -s   => 지정한 디렉토리 내에 존재하는 파일의 sum
    du -h   => 결과내용을 가독성있게 표시
    du -d 1 => 1 depth 디렉토리까지 용량 확인

    du -sh /home/ubuntu
    du -h -d 1 /home/ubuntu
    du -h -d 1 /home/ubuntu | sort -h -r

    ## ****
    du -h -d 1 / 2> /dev/null | sort -h -r | head -n 20

    du -h -d => 디스크사용량을 읽기 편하게 보되
    1 / 2> /dev/null => 1 depth 까지보고 / 위치에서 2> /dev/null 에러무시

    du -h -d 2 /var 2> /dev/null | sort -h -r | head -n 20
```

> 기존시스템에 새로운 디스크 추가하기 \*\*\*

```sh
    lsblk               ## 현재 파일시스템 보기

    df -h
    sudo file -s /dev/nvme0n1p1 ## 현재 마운트된 파일시스템 보기

    sudo mkfs -t ext4 /dev/nvme2n1 ## 새로운 파일시스템 만들기
    sudo mkdir /data               ## /dev/nvme2n1이랑 mapping할 폴더

    sudo mount /dev/nvme2n1 /data
    df -h
    ## /dev/nvme2n1     20G   24K   19G   1% /data 이렇게 마운트가 됨
    mount | grep data

    ## 파일시스템 테이블에 등록해서 재부팅해도 Default로 동작하게 하기
    sudo cp /etc/fstab /etc/fstab.orig
    sudo vi /etc/fstab

    sudo blkid                      ## mount된 uuid 리스트 => 여기서 새롭게 마운트된 놈 copy

    sudo vi /etc/fstab
    UUID=4870ba44-116b-4b5f-b59a-12bad1cba74c /data ext4 defaults,discard,nofail 0 2

    ## test
    sudo umount /data
    sudo mount -a               ## 이전 마운트 내역 복구
```

- <a href="https://docs.aws.amazon.com/ko_kr/AWSEC2/latest/UserGuide/ebs-using-volumes.html"> Mount </a>

## User Management

```sh
    cat /etc/passwd

    ## [로그인명]:[암호화된 암호]:[UID]:[GroupID]:[사용자정보]:[홈 디렉토리]:[로그인 쉘]
    ## rpcuser:x:29:29:RPC Service User:/var/lib/nfs:/sbin/nologin
    ## tcpdump:x:72:72::/:/sbin/nologin
    ## ec2-user:x:1000:1000:EC2 Default User:/home/ec2-user:/bin/bash

    ## 비밀번호 관리
    cat /etc/shadow

    ## 그룹 관리
    cat /etc/group

    ## 사용자 생성
    sudo useradd john
    sudo useradd -m -s /bin/bash jane
    sudo userdel jane -r # -r 홈디렉토리 삭제여부

    ## steve 유저 추가 및 root 그룹 추가
    sudo useradd -m -s /bin/dash steve  ## 사용자 추가
    sudo passwd steve                   ## passwd 설정

    cat /etc/passwd                     ## 사용자 확인
    cat /etc/group                      ## 사용자의 대한 그룹 확인

    sudo usermod -G root steve          ## root 사용자 추가 => cat /etc/group

    cat /etc/group                      ## 사용자의 대한 그룹 확인
    sudo userdel -r steve
```

> service 유저 만들기

```sh
    ## -r system user
    ## -s shell
    sudo useradd -r -s /usr/sbin/nologin jenkins
    grep jenkins /etc/passwd /etc/shadow
    userdel jenkins -r
```

> 앱 구동용 서비스 유저 만들기

- ./user-docker

> 최강의 Bastion host만들기 (ssh + Google Authenticator)

```sh
    cd /best-bastion-host
    terraform init && terraform apply
    sh scp.sh

    ## in instance use ssh
    sh mfa.sh

    ## Backup
    sudo cp /etc/pam.d/sshd /etc/pam.d/sshd.bak

    ## sshd 설정 변경
    sudo vi /etc/pam.d/sshd

    # Standard Un*x authentication.
    # @include common-auth                           => 주석 처리
    @include common-password                       # => Add
    auth required pam_google_authenticator.so      # => Add
    auth required pam_permit.so                    # => Add

    ## 백업
    sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

    ## sshd 설정변경
    sudo vi /etc/ssh/sshd_config

    # To disable tunneled clear text passwords, change to no here!
    PasswordAuthentication no
    #PermitEmptyPasswords no
    ChallengeResponseAuthentication yes                                     # => Add
    AuthenticationMethods publickey,password publickey,keyboard-interactive # => Add

    ## 재시작
    sudo systemctl restart sshd.service
```
