## 파이프

- 파이프를 사용하여, 2개의 명령어를 연결한다

```sh
ls | grep pam.d
ps -ef | grep bash
```

## 필터

- grep, tail ,wc ,srot ,awk, sed

```sh
history | grep clear
...
```

## 리디렉션

- 표준 입출력의 방향을 바꿈

```sh

## append
echo hello world >> a.txt

## overwrite
echo hello world > a.txt

## multiline
cat <<EOF > a.txt
hello-1
hello-2
hello-3
hello-4
EOF
```
