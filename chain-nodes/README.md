## geth版本 1.10.25
* 官方文档
https://docs.prylabs.network/docs/install/install-with-script

* 从已有信标节点同步
https://docs.prylabs.network/docs/prysm-usage/checkpoint-sync

* 查询节点状态命令
https://docs.prylabs.network/docs/monitoring/checking-status

## 创建一个目录并下载命令文件
mkdir prysm && cd prysm
curl https://raw.githubusercontent.com/prysmaticlabs/prysm/master/prysm.sh --output prysm.sh && chmod +x prysm.sh

## 生产jwt
./prysm.sh beacon-chain generate-auth-secret

## 启动geth
在原有命令上加上(注意替换路径)   --authrpc.jwtsecret /path/to/jwt.hex 

## 取infura注册一个eth2节点，否则同步要很久
infura_eth2_endpoint

## 启动信标链
直接启动会报个错，需要加一个flag,类似接受协议

`--accept-terms-of-use`

另外有个flag 是替换手续费接受地址，要么随便替换个地址，或者不要这个flag （针对不质押32eth）

(下面命令替换地址，替换{infura_eth2_endpoint})

8551是geth里面的一个默认端口， 如需修改这个端口，要先在启动geth时修改 --authrpc.port value (default: 8551)

```
nohup ./prysm.sh beacon-chain --execution-endpoint=http://localhost:8551 --jwt-secret=./jwt.hex --suggested-fee-recipient=随便替换地址  --accept-terms-of-use --checkpoint-sync-url=infura_eth2_endpoint --genesis-beacon-api-url=infura_eth2_endpoint &
```
