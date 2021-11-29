#!/bin/bash

#instance default is 1
instance=1;

while getopts i:w:p: flag
do
    case "${flag}" in
        i) instance=${OPTARG};;
        w) wallet=${OPTARG};;
        p) pull=${OPTARG};;
    esac
done

if [ -z "$wallet" ]; then 
  echo "Need to enter the parameter '-w your_wallet_key'";
  exit 1;
fi

if [ -z "$pull" ]; then 
  echo "Need to enter the parameter '-p pool-url:port' ex: gulf.moneroocean.stream:10128";
  exit 1;
fi

#remove all container with name monero
docker container rm -f $(docker container ls -qa -f name=monero)

#update or donwload container image
docker pull hassegawa/monero

#run new container
for (( c=1; c<=$instance; c++ ))
do  
  docker run -d --name monero_$c --env POOL_URL=$pull --env WALLET=$wallet --env WORKER_NAME=miner_$instance  hassegawa/monero
done
