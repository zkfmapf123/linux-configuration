# 제일 디스크 사용량 많은 놈 찾기

du -h -d 1 / 2> /dev/null | sort -h | head -n 20

# var 이 많이나옴

du -h -d 2 /var 2> /dev/null | sort -h -r | head -n 20

# var/lib

du -h -d 3 /var/lib 2> /dev/null | sort -h -r | head -n 20