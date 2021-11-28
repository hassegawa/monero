#!/bin/bash

#remove all container
docker container rm -f $(docker container ls -qa -f name=monero)

#update or donwload container image
docker pull hassegawa/monero

#run new container
docker run -d --name monero_01 --env POOL_URL=gulf.moneroocean.stream:10128 --env WALLET=[WALLET] --env WORKER_NAME=pc_001  hassegawa/monero

#docker run -d --name monero_02 --env POOL_URL=gulf.moneroocean.stream:10128 --env WALLET=[WALLET] --env WORKER_NAME=pc_002  hassegawa/monero

#docker run -d --name monero_03 --env POOL_URL=gulf.moneroocean.stream:10128 --env WALLET=[WALLET] --env WORKER_NAME=pc_003  hassegawa/monero