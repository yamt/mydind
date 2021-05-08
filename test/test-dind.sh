#! /bin/sh

docker version
docker buildx version

PLATFORMS="linux/amd64 linux/arm64"

for P in $PLATFORMS; do
    NAME=alpine:3.12.0
    docker run \
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
        --platform $P \
        ${NAME}
done
