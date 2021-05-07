#! /bin/sh

docker build -t yamt/mydind .
docker run yamt/mydind docker version
