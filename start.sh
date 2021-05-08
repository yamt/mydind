#! /bin/sh

tmux new -d -s docker dockerd

# wait for the docker api getting ready
while ! docker version > /dev/null 2>&1; do sleep 1; done

# enable multiarch if it isn't already.
# (docker desktop has it enabled by default)
mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc
if [ ! -f /proc/sys/fs/binfmt_misc/qemu-aarch64 ]; then
    echo "It seems that multiarch is not configured. Trying to enable it..."
    docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
fi
test -f /proc/sys/fs/binfmt_misc/qemu-aarch64
umount /proc/sys/fs/binfmt_misc

if [ $# -eq 0 ]; then
    tmux a -t docker
else
    exec $@
fi
