img=tronprotocol/java-tron:latest

HOME_DIR=/opt/bigdata/tron-mainnet/

docker run -itd -p 8090:8090 -p 8091:8091 -p 18888:18888 -p 50051:50051 \
    --name tron-main \
    -v $HOME_DIR/output-directory:/java-tron/output-directory \
    -v $HOME_DIR/logs:/java-tron/logs \
    -v $HOME_DIR/config:/java-tron/config \
    --privileged=true \
    $img -c ./config/main_net_config.conf
