#!/bin/bash

echo '=> stopping containers ...'
docker stop $(docker ps -a -q)

if [ "$1" = "clean" ]; then
  echo '=> removing containers ...'
  docker rm $(docker ps -a -q)
fi


# echo '=> deleteing images ..'
# docker image rm --force $(docker images -q) 

