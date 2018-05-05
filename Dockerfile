ARG BASE=alpine
FROM $BASE

ARG arch=arm
ENV ARCH=$arch

COPY qemu/qemu-$ARCH-static* /usr/bin/

RUN set -xe && \
    apk update && apk upgrade && \
    apk add --no-cache --virtual=run-deps \
    python py-requests && \
    set -xe && apk del --progress --purge && rm -rf /var/cache/apk/*

RUN mkdir /data
VOLUME /data
WORKDIR /data
CMD [ "sh" ]
