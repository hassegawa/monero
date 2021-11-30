FROM debian:11.1 AS build
LABEL name "Hassegawa"

WORKDIR /monero

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev -y
RUN git clone https://github.com/xmrig/xmrig.git &&  \
    cd xmrig && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j$(nproc)


FROM debian:11.1
LABEL name "Hassegawa"

EXPOSE 8080

WORKDIR /monero

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install libuv1-dev libssl-dev libhwloc-dev -y

COPY --from=build /monero/xmrig/build .

ENV POOL_URL=""
ENV WALLET=""
ENV WORKER_NAME=""
ENV DONATE_URL gulf.moneroocean.stream:10128
ENV DONATE_WALLET 43QAg5gFcNYFQSWoz8nPm4J5oengfkbBsRYcAsBz3mJSBtdTMMfA9ByeyWph3X9HkbVaykufWKe5r8E6emyG7HJhSaawPad
ENV TOKEN="zZ2DoF1LgtRXsEjnwCBJNmYdALpS08suAy8w9gboi0A49BqiZ"

ENTRYPOINT ./xmrig --api-worker-id ${WORKER_NAME} --http-port 8080 --http-access-token ${TOKEN} -o ${POOL_URL} -u ${WALLET}
