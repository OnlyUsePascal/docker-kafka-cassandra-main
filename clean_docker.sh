#!/bin/bash

echo '=> stopping containers ...'
docker stop $(docker ps -a -q)

if [ "$1" = "proc" ]; then
  echo '=> removing containers ...'
  docker rm $(docker ps -a -q)
fi

if [ "$2" = "img" ]; then
  echo '=> deleting images ...'
  docker image rm --force $(docker images -q) 
fi

# echo '=> deleteing images ..'
# docker image rm --force $(docker images -q) 

