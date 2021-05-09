#! /bin/sh

set -e

tmux new -d -s docker dockerd

echo "Waiting for the docker api getting ready..." >&2
while ! docker version > /dev/null 2>&1; do sleep 1; done

# enable multiarch if it isn't already.
# (docker desktop has it enabled by default)
mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc
if [ ! -f /proc/sys/fs/binfmt_misc/qemu-aarch64 ]; then
    echo "It seems that multiarch is not configured. Trying to enable it..." >&2
    docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
fi
test -f /proc/sys/fs/binfmt_misc/qemu-aarch64
umount /proc/sys/fs/binfmt_misc

if [ $# -ne 0 ]; then
    exec $@
fi
exec tmux a -t docker
