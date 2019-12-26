ARG BASE=alpine
FROM $BASE

ARG arch=arm
ENV ARCH=$arch

COPY qemu/qemu-$ARCH-static* /usr/bin/

RUN set -xe && \
    apk update && apk upgrade && \
    apk add --no-cache --virtual=run-deps \
    python3 py3-requests && \
    set -xe && apk del --progress --purge && rm -rf /var/cache/apk/*

COPY *.py /usr/local/bin/

RUN mkdir /data
VOLUME /data
WORKDIR /data
CMD [ "getcomics_RSS.py" ]
