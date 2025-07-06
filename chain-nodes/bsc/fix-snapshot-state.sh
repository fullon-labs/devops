#docker run -it --name bsc -v `pwd`/data:/data bnb-chain/bsc:1.1.18_hf bash
docker run -it --name bsc -v `pwd`/data:/data bnb-chain/bsc:1.1.18_hf geth --config /data/config.toml
#docker run -it --name bsc -v `pwd`/data:/data bnb-chain/bsc:1.1.18_hf geth --config /data/config.toml --snapshot=false
