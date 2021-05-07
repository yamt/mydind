#! /bin/sh

docker version
docker buildx version

cd $(dirname $0)
cd alpine
docker buildx build -t test .
docker run test
