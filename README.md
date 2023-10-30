# Linux Configuration

## Execute

```
    cd infra && terraform init && terraform apply
```

## Systemd

- [Systemd](./systemd/)

## Process

- [Process](./%ED%94%84%EB%A1%9C%EC%84%B8%EC%8A%A4%EA%B4%80%EB%A6%AC/)

## Disk

- [Disk](./%EB%94%94%EC%8A%A4%ED%81%AC%EA%B4%80%EB%A6%AC/)

## 최강의 Bastion host만들기 (ssh + Google Authenticator)

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

## Log Management

- [로깅처리](./%EB%A1%9C%EA%B9%85%EC%B2%98%EB%A6%AC/)

## 리눅스 네트워크

- [네트워크](./%EB%84%A4%ED%8A%B8%EC%9B%8C%ED%81%AC/)

## 파이프*필터*리디렉션

- [파이프*필터*리디렉션](./파이프_필터_리디렉션/README.md)

## Shell Programming

- [Shell Programming](./shell-programming/)

## Todo

- [ ] Jenkins System 으로 등록해서 사용하기
- [ ] 로그 대량으로 발생해서 logrotate로 관리
- [ ] 에러 로그는 슬랙알람으로 발생하게 처리하기
