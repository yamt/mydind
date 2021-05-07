#! /bin/sh

docker build -t yamt/mydind .
docker run --privileged -v$(pwd):/src yamt/mydind /src/test/test-dind.sh
