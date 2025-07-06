FROM debian:10 as builder

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get -q -y update && \
    apt-get -q -y install wget \
                          curl \
                          git \
                          unzip \
                          build-essential && \
    wget https://golang.org/dl/go1.19.linux-amd64.tar.gz && tar -zxvf go1.19.linux-amd64.tar.gz -C /usr/local/ && \
    echo "export PATH=/usr/local/go/bin:${PATH}" | tee /etc/profile.d/go.sh && . /etc/profile.d/go.sh && go version && \
    apt-get -q -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    \
    git clone -b v1.2.12 https://github.com/binance-chain/bsc /bsc && \
    cd /bsc && \
    make geth && \
    cd / && \
    bsc_download_url=https://api.github.com/repositories/265775217/releases/latest && \
    \
    wget   $(curl -s $bsc_download_url |grep browser_ |grep mainnet |cut -d\" -f4) && \
    wget   $(curl -s $bsc_download_url |grep browser_ |grep testnet |cut -d\" -f4) && \
    \
    cp /bsc/build/bin/geth /usr/bin/geth && \
    tar cvf /transfer.tar /usr/bin/geth /*.zip

FROM debian:10

ENV NETWORK=main
CMD mkdir -p /opt/bigdata/bsc-mainnet/data
WORKDIR /opt/bigdata/bsc-mainnet/data
COPY --from=builder /transfer.tar ./transfer.tar

RUN tar xvf ./transfer.tar && mv ./usr/bin/geth /usr/bin/geth && rm -rf ./usr \
  \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get -q -y update && \
  apt-get -q -y install unzip && \
  apt-get -q -y clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  [ ! -f './genesis.json' ] && unzip ./"${NETWORK}net.zip" && \
  geth --datadir . init ./genesis.json && sed -i '/^HTTP/d' ./config.toml

# NODE P2P
EXPOSE 30311/udp
EXPOSE 30311/tcp

# pprof / metrics
EXPOSE 6060/tcp

# HTTP based JSON RPC API
EXPOSE 8545/tcp
# WebSocket based JSON RPC API
EXPOSE 8546/tcp
# GraphQL API
EXPOSE 8547/tcp

CMD ["sh", "-xc", "exec", "geth", "--config", "./config.toml", "--datadir", ".", "--http", "--http.addr", "0.0.0.0", "--metrics", "--http.port","8545","--http.api","eth,net,web3","--ws", "--ws.port", "3334", "--ws.api", "eth,net,web3", "--http.vhosts=*"]
