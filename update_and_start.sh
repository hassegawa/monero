#!/bin/bash

#instance default is 1
instance=1;

while getopts i:w: flag
do
    case "${flag}" in
        i) instance=${OPTARG};;
        w) wallet=${OPTARG};;
    esac
done

if [ -z "$wallet" ]; then 
  echo "Need to enter the parameter '-w your_wallet_key'";
  exit 1;
fi

#remove all container with name monero
docker container rm -f $(docker container ls -qa -f name=monero)

#update or donwload container image
docker pull hassegawa/monero

#run new container
for (( c=1; c<=$instance; c++ ))
do  
  docker run -d --name monero_$c --env POOL_URL=gulf.moneroocean.stream:10128 --env WALLET=[WALLET] --env WORKER_NAME=pc_$instance  hassegawa/monero
done
