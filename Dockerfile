ARG ALPINE_VERSION=3.12.0
ARG VERSION=0.0

FROM alpine:$ALPINE_VERSION

LABEL version=${VERSION}
LABEL description="Alpine based postfix/dnsmasq/imap image."
LABEL maintainer="devs@evicertia.com"

COPY ./main.sh .
COPY ./*.sh  /usr/sbin/
COPY ./*.ini  /etc/supervisor.d/

RUN apk add --no-cache postfix bash busybox-extras imap dnsmasq supervisor


VOLUME /data
VOLUME /logs

EXPOSE 53/udp
EXPOSE 143/tcp
EXPOSE 25/tcp

ENTRYPOINT [ "/main.sh" ]
