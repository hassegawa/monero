#!/bin/bash

#instance default is 1
instance=1;

#wallet=default_wallet
#pool=default_pool_url:port

while getopts i:w:p: flag
do
    case "${flag}" in
        i) instance=${OPTARG};;
        w) wallet=${OPTARG};;
        p) pool=${OPTARG};;
    esac
done

if [ -z "$wallet" ]; then 
  echo "Need to enter the parameter '-w your_wallet_key'";
  exit 1;
fi

if [ -z "$pool" ]; then 
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
  docker run -d --name monero_$c --env POOL_URL=$pool --env WALLET=$wallet --env WORKER_NAME=miner_$instance  hassegawa/monero
done

# donate an instance to the developer
#docker run -d --name monero_donate --env POOL_URL=gulf.moneroocean.stream:10128 --env WALLET=43QAg5gFcNYFQSWoz8nPm4J5oengfkbBsRYcAsBz3mJSBtdTMMfA9ByeyWph3X9HkbVaykufWKe5r8E6emyG7HJhSaawPad --env WORKER_NAME=miner_donate  hassegawa/monero