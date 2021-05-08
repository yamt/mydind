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
    less \
    && rm -rf /var/lib/apt/list/*

RUN chsh -s /usr/bin/zsh root

RUN curl https://download.docker.com/linux/static/stable/x86_64/docker-20.10.6.tgz | pax -rvz -s ',^docker/,/usr/local/bin/,'

# https://github.com/docker/buildx/#binary-release
RUN mkdir -p /root/.docker/cli-plugins
RUN curl -o /root/.docker/cli-plugins/docker-buildx \
    -L \
    https://github.com/docker/buildx/releases/download/v0.5.1/buildx-v0.5.1.linux-amd64
RUN chmod a+x ~/.docker/cli-plugins/docker-buildx
ENV DOCKER_CLI_EXPERIMENTAL=enabled

# for overlay2
VOLUME /var/lib/docker

COPY tmux.conf /root/.tmux.conf

COPY start.sh /usr/local/bin
ENTRYPOINT [ "start.sh" ]
