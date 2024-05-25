FROM alpine:3.20.0
LABEL org.opencontainers.image.authors="expert@slackarea.net"

RUN apk add -U \
    openssh-server \
    rsync && \
    rm -f /var/cache/apk/*
ADD sshd_config /etc/ssh/
# WARNING: The ssh server key is fixed at build time, rebuild to change the key
RUN /usr/bin/ssh-keygen -q -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key -C '' -N ''
RUN /usr/bin/ssh-keygen -q -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -C '' -N ''
#ADD create-users-and-run.sh /usr/local/bin/

EXPOSE 22
#ENTRYPOINT ["/usr/sbin/sshd", "-D", "-e"]
#ENTRYPOINT ["create-users-and-run.sh"]
CMD ["/usr/sbin/sshd", "-D", "-e"]
#STOPSIGNAL INT