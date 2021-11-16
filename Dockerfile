FROM debian:11.1 AS build
LABEL name "Hassegawa"

WORKDIR /monero

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update 
RUN apt-get install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev -y
RUN git clone https://github.com/xmrig/xmrig.git &  \
    cd xmrig & \
    mkdir build & \
    cd build & \
    cmake .. & \
    make


FROM debian:11.1
LABEL name "Hassegawa"

WORKDIR /monero

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install libuv1-dev libssl-dev libhwloc-dev -y

COPY --from=build /monero/xmrig/build .

ENV POOL_URL=""
ENV WALLET=""
ENV WORKER_NAME=""

ENTRYPOINT ./xmrig -o ${POOL_URL} -u ${WALLET} -p ${WORKER_NAME}
