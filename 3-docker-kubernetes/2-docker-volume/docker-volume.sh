#!/usr/bin/env sh

docker volume create --name db

docker volume ls

docker run \
  -d \
  -it \
  --name fastcampus-mysql \
  -e MYSQL_DATABASE=fastcampus \
  -e MYSQL_ROOT_PASSWORD=fastcampus \
  -v db:/var/lib/mysql \
  -p 3306:3306 \
  --platform linux/amd64 mysql \
  mysql:5.7
