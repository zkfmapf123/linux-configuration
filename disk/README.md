# Disk

## 파일시스템

- 스토리지장치에 파일을 명령/저장/읽어내는 시스템

## 디스크기반 파일 시스템

- Linux => EXT3, EXT4, ZFS, BTRFS
- Windows => FAT, NTFS
- MacOS => HFS, APFS

## 네트워크 파일시스템

- NFS, SMB, CIFS

## 특수파일 시스템 (특수목적의 소량의 용량)

- prod, sysfs, tmpfs, cgroup

## 실습

- [x] 디스크 사용량 측정하는 Script
- [x] 디스크 사용량이 어느정도 찼을때 Slack 알림

  - <a href="https://jojoldu.tistory.com/552"> Slack hook 추가 </a>

    ```sh
        cat <<EOF > disk_check_cron
        ...
        EOF
    ```

  - CronTab 설정

    ```sh
        */30 * * * * /usr/local/bin/volume_check_script.sh

        crontab -e
    ```

- [ ] 디스크 마운트
- [ ] 디스크 마운트 기존 확장
- [ ] Window Server 볼륨확장하기

## Reference

- <a href="https://crontab.guru/#*_*_*_*_*"> 크론탭 생성기 </a>
