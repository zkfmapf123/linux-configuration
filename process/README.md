# Process

## Desc

- pid => 커널은 각 프로세스에 고유한 ID를 부여
- ppid
  - 리눅스에서는 새 프로그램을 시작하는 시스템 콜이 없음
  - 기존 프로세스를 복제 및 교체하는 방식으로 운용
  - 기존 프로세스는 새로운 프로세스를 생성하고 자신을 복제 함
  - ppid는 그 프로세르르 복제한 부모의 pid

```sh
    pstree -p
```

## proc

```sh

    ## 모든 프로세스의 대한 정보를 표시
    cd /proc/
```

## Script

```sh
    ## 실행중인 모든 프로세스의 대한 정보를 표시
    ps aux

    ## 실행중인 모든 프로세스 정보를 표시 => 좀더 가볍게 동작 (교착상태 시)
    ps lax

    ## tree 형식으로
    ps auxf

    ## GraceFully Kill
    sudo kill -15

    ## Just Kill => 좀비 프로세스가 생길 수 있음
    sudo kill -9
```

## Example (CronTab으로 로그파일 관리하기)

- 운영중의 로그파일의 Disk full이 발생할것을 방지하기 위해서...
- Root Volume 에러나면 답없음...

> 로그파일 관리 요구사항

- [ ] 매일 로그파일 관리
- [ ] 날짜가 지나면 로그파일을 Rotate
- [ ] 날짜가 지난 로그는 access.log, access.log.1, ...
- [ ] 2주가 지난 로그파일은 삭제
- [ ] 오래된 로그파일은 압축된 형태로 저장

```sh

    ## nginx
    ## cd /etc/systemd/system/nginx.service.d
    sudo yum install nginx
    sudo systemctl start nginx

    ## Cron 데이터를 사용
    cd /etc/cron.daily
    cd /etc/cron.*

    ## logrotate를 사용하면 편함 (압축, 제거, 특정기간동안 관리, 메일전송기능)
    보통 crontab + logrotate를 사용해야 한다.
```

## Reference

- <a href="https://server-talk.tistory.com/271"> logrotate </a>
