## fix snapshot states

### step-1: 
`docker run -it --name bsc -v `pwd`/data:/data bnb-chain/bsc:1.1.18_hf bash`

### step-2: 
`docker run -it --name bsc -v `pwd`/data:/data bnb-chain/bsc:1.1.18_hf geth --config /data/config.toml`

### step-3:
`docker run -it --name bsc -v `pwd`/data:/data bnb-chain/bsc:1.1.18_hf geth --config /data/config.toml --snapshot=false`


## attach BSC: `bsc-attach.sh`

```
HOME=/opt/bigdata/bsc-mainnet
docker exec -it bsc-main geth attach $HOME/data/geth.ipc
```
