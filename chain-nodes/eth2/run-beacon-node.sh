#infura_eth2_endpoint=https://2Ey9xIUR23mcfOyemOLmviwDZ47:08c6ba67935179d367e53670af11de2f@eth2-beacon-mainnet.infura.io
infura_eth2_endpoint=https://2EyTGBoVrXGrFJOdzXg4Cxz80TW:ec8b9cabff88776002ab5ce42b8af268@eth2-beacon-mainnet.infura.io

tag=$1
eth_uri=http://172.17.83.85:18551

docker run -d -v /opt/bigdata2/prysm:/data -p 4000:4000 -p 13000:13000 -p 12000:12000/udp --name beacon-node \
  gcr.io/prysmaticlabs/prysm/beacon-chain:$tag \
  --datadir=/data \
  --jwt-secret=/data/jwt.hex \
  --rpc-host=0.0.0.0 \
  --grpc-gateway-host=0.0.0.0 \
  --monitoring-host=0.0.0.0 \
  --execution-endpoint=$eth_uri \
  --accept-terms-of-use=true \
  --checkpoint-sync-url=$infura_eth2_endpoint \
  --genesis-beacon-api-url=$infura_eth2_endpoint \
  --suggested-fee-recipient=0xe99733f2dc082f21d4d7e542440d0aeb6b46ecfa
