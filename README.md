# Linux Configuration

## Execute

```
    cd infra && terraform init && terraform apply
```

## Systemd

- [Systemd](./systemd/)

## Process

- [Process](./process/)

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
