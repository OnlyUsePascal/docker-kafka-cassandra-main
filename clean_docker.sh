#!/bin/bash

echo '=> stopping containers ...'
docker stop $(docker ps -a -q)

echo '=> removing containers ...'
docker rm $(docker ps -a -q)

# echo '=> deleteing images ..'
# docker image rm $(docker images -q) 

