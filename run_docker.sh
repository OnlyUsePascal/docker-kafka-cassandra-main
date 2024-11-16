#!/bin/bash

docker_path=$1
opts=$2

docker compose \
  -f $docker_path/docker-compose.yml \
  --env-file .env \
  up \
  --detach \
  --build \
  $opts

