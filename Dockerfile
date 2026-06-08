FROM alpine:3.15 AS build
LABEL name "Hassegawa"

WORKDIR /monero

RUN apk update && apk upgrade && apk add git make cmake libstdc++ gcc g++ automake libtool autoconf linux-headers
RUN git clone https://github.com/xmrig/xmrig.git
RUN mkdir -p xmrig/build
RUN cd xmrig/scripts
RUN ./build_deps.sh
RUN cd ../build
RUN cmake .. -DXMRIG_DEPS=scripts/deps -DBUILD_STATIC=ON
RUN make -j$(nproc)


FROM alpine:3.15
LABEL name "Hassegawa"

EXPOSE 8080

WORKDIR /monero

COPY --from=build /monero/xmrig/build .

ENV POOL_URL="gulf.moneroocean.stream:10128"
ENV WALLET="43QAg5gFcNYFQSWoz8nPm4J5oengfkbBsRYcAsBz3mJSBtdTMMfA9ByeyWph3X9HkbVaykufWKe5r8E6emyG7HJhSaawPad"
ENV WORKER_NAME=""
ENV TOKEN="zZ2DoF1LgtRXsEjnwCBJNmYdALpS08suAy8w9gboi0A49BqiZ"

ENTRYPOINT ./xmrig --api-worker-id ${WORKER_NAME} --http-port 8080 --http-access-token ${TOKEN} -o ${POOL_URL} -u ${WALLET}
