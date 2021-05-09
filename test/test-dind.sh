#! /bin/sh

set -e
set -x

docker version
docker buildx version
docker system info

PLATFORMS="linux/amd64 linux/arm64"

for P in $PLATFORMS; do
    NAME=alpine:3.12.0
    docker run \
        --rm \
        --platform $P \
        ${NAME} \
        uname -a
done

cd $(dirname $0)
cd alpine

for P in $PLATFORMS; do
    NAME=test-$(echo $P | tr / -)
    docker buildx build \
        --platform $P \
        -t ${NAME} \
        --load \
        .
done

for P in $PLATFORMS; do
    NAME=test-$(echo $P | tr / -)
    docker run \
        --rm \
        --platform $P \
        ${NAME}
done
