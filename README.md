# Container
  * debian:11.1

# XMRIG code
  * https://github.com/xmrig/xmrig
  * https://xmrig.com/docs/miner/command-line-options

# install monero wallet
  * https://www.getmonero.org/downloads/
  * https://www.youtube.com/watch?v=hHtGN_JzoP8&t=1015s


# pool:
  * https://moneroocean.stream/

# Docker command:
  * docker run -d --name monero_01 --env POOL_URL=[URL.POOL] --env WALLET=[MONERO.WALLET] --env WORKER_NAME=[NAME.WORK.LABEL]  hassegawa/monero

# Reference
  * https://www.youtube.com/watch?v=hHtGN_JzoP8

# Github project
  * https://github.com/hassegawa/monero


# Scritp to start or update container
  * create a file: start.sh

       * get script [here](https://raw.githubusercontent.com/hassegawa/monero/main/update_and_start.sh)
       
  *  run script:
       * -i to number of instance; deafult 1
       * -w to wallet 
       * -p pool url; ex: gulf.moneroocean.stream:10128

            * start.sh -i 2 -w your-public-wallet-key -p pool-url:port