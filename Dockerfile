FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    curl \
    iptables \
    make \
    m4 \
    zsh \
    pax \
    tmux \
    vim \
    less

RUN chsh -s /usr/bin/zsh root

RUN curl -o docker.tgz \
    https://download.docker.com/linux/static/stable/x86_64/docker-20.10.6.tgz
RUN pax -rvzf docker.tgz -s ',^docker/,/usr/local/bin/,'

# https://github.com/docker/buildx/#binary-release
RUN curl -o docker-buildx \
    -L \
    https://github.com/docker/buildx/releases/download/v0.5.1/buildx-v0.5.1.linux-amd64
RUN mkdir -p /root/.docker/cli-plugins
RUN mv docker-buildx /root/.docker/cli-plugins
RUN chmod a+x ~/.docker/cli-plugins/docker-buildx
ENV DOCKER_CLI_EXPERIMENTAL=enabled

COPY tmux.conf /root/.tmux.conf

COPY start.sh /usr/local/bin
CMD [ "start.sh" ]
