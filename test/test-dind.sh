#! /bin/sh

docker version
docker buildx version

cd $(dirname $0)
cd alpine

PLATFORMS="linux/amd64 linux/arm64"

for P in $PLATFORMS; do
    docker buildx build \
        --platform $P \
        -t test-$P \
        --load \
        .
done

for P in $PLATFORMS; do
    docker run test-$P
done
