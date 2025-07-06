ver=$1
[ -z "$ver" ] && ver=1.14.6

docker build --build-arg version=$ver . -t=dogecoin/core:$ver
