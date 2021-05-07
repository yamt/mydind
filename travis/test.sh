#! /bin/sh

docker build -t yamt/mydind .
docker run --privileged -v$(pwd):/src yamt/mydind /src/travis/test-dind.sh
