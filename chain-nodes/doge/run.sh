TAG=$1

[ -z "$TAG" ] && TAG=1.14.6
IMG=dogecoin/core:$TAG
CON=dogecoin-main

mkdir -p ./data

docker run -d --name $CON \
	-p 22555:22555 -p 22556:22556 \
	-v `pwd`/data:/root/.dogecoin $IMG
