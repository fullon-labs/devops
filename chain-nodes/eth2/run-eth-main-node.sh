tag=$1

docker run -d --name eth-main \
	   -v /opt/bigdata2/eth-mainnet:/data \
	   -v /opt/bigdata2/prysm:/prysm \
           -p 28545:8545 -p 18551:8551 -p 30303:30303 \
           ethereum/client-go:$tag --datadir /data --http --http.addr 0.0.0.0 \
	   --http.api "eth,admin,personal,net,web3,db,txpool,ws" --http.vhosts=* --ws --ws.addr 0.0.0.0 \
	   --authrpc.addr 0.0.0.0 --authrpc.jwtsecret /prysm/jwt.hex
