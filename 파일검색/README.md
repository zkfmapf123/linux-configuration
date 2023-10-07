# 파일검색

## find

```sh
    ## *.service 들 모두 찾기
    find /etc/systemd -name "*.service"

    ## /etc/systemd 디렉토리 하위 파일중 10KB ~ 100KB 파일검색
    find /etc/systemd -size +10k -size -100k

    ## 응용
    find /etc/systemd -size +10k -size -100k >> hello.txt
```
