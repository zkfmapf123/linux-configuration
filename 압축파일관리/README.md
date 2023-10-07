# 압축파일 관리

## Desc

- 예전에는 gz를 사용했으나, 압축률이 더 좋은 xz나 bz2를 사용하는게 더 좋음

## PreStart

```sh

    cat <<EOF > hello.txt
    AAAAAA
    AAAAAA
    AAAAAA
    AAAAAA
    AAAAAA
    AAAAAA
    AAAAAA
    AAAAAA
    EOF
```

## xz

```sh
    xz --help
```

## bzip2

```sh
    bzip2 --help
```

## gzip (주로 나는 이걸 많이 사용함)

```sh

    gzip --help
```

## xz vs bzip2 vs gzip benchmark

- 대상 bigfile.txt (160MB)

|             | xz   | bzip2 | gzip |
| ----------- | ---- | ----- | ---- |
| 압축후 용량 | 26K  | 617K  | 966K |
| 압축시간    | 보통 | 느림  | 빠름 |

- xz가 준수한데? -> 빨리 처리하려면 gzip도 나쁘진 않지만 -> XZ를 써야할듯함

## 파일 묶기 + 파일 묶은 후 xz로 압축하기

```sh

    ## 기본 묶음
    tar cvf my.tar /*

    ## 기본 풀기
    tar xf my.tar

    ## 묶은 후 xz로 압축 +J
    tar cvfJ my.tar.xz /*

    ## 묶은 후 xz로 Decompress +J
    tar xfJ my.tar.xz
```
