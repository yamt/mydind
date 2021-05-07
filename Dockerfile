FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    curl \
    iptables \
    make \
    m4 \
    zsh \
    pax \
    tmux

RUN curl -o docker.tgz \
    https://download.docker.com/linux/static/stable/x86_64/docker-20.10.6.tgz
RUN pax -rvzf docker.tgz -s ',^docker/,/usr/local/bin/,'


