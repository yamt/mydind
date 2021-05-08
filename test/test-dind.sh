#! /bin/sh

docker version
docker buildx version

cd $(dirname $0)
cd alpine

PLATFORMS="linux/amd64 linux/arm64"

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
    docker run ${NAME}
done
