#! /bin/sh

tmux new -d -s docker dockerd

# wait for the docker api getting ready
while ! docker version > /dev/null 2>&1; do sleep 1; done

if [ $# -eq 0 ]; then
    tmux a -t docker
else
    exec $@
fi
