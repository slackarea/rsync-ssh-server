#!/bin/sh
set -eu

GROUPID="${GROUPID:-1000}"
USER="${USER:-backup}"
addgroup -g $GROUPID rsync
adduser -G rsync -s /bin/sh -D $USER
echo $USER:$(head -c30 /dev/urandom | base64) | chpasswd
mkdir -p /home/$USER/.ssh
chown -R $USER:rsync /home/$USER/.ssh
chmod -R go-wx /home/$USER/.ssh
done

exec /usr/sbin/sshd -eD