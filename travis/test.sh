#! /bin/sh

docker build -t yamt/mydind .
docker run --privileged yamt/mydind docker version
