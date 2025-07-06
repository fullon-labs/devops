# Build Docker Image

```shell
TAG=GreatVoyage-v4.7.0.1
git clone https://github.com/tronprotocol/java-tron.git
git checkout $TAG

cd ./java-tron/docker

## edit Dockerfile to update tag info inside

docker build -t tronprotocol/java-tron .

```
