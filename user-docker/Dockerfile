## Before
# FROM ubuntu:20.04

# CMD ["sleep", "infinity"]

## After
FROM ubuntu:20.04

RUN groupadd -r app &&\
    useradd -r -g app -d /home/app -c "docker image user" app

USER app

CMD ["sleep", "infinity"]

## docker build -t sleep .
## docker run --rm -d --name user_test user_test
## docker exec -it user_test id => root로 잡힘 (default)

## cat <<EOF > Dockerfile
##
##
##
##
## EOF

## docker exec -it user_test id => uid(app)