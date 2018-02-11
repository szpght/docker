FROM alpine
LABEL maintainer "Brett Vickers <github.com/beevik>"

RUN set -x \
	&& addgroup -g 1000 redis \
	&& adduser -G redis -u 1000 -D -H -s /sbin/nologin redis

RUN set -x \
	&& apk update \
	&& apk add openssl bash redis

ENV GOSU_VERSION 1.10
RUN set -x \
	&& apk add --no-cache --virtual .gosu-deps dpkg gnupg openssl bash redis \
	&& wget -q -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true \
	&& apk del .gosu-deps

RUN set -x \
	&& mkdir /data \
	&& chown redis:redis /data

COPY files/docker-entrypoint.sh /entrypoint.sh

EXPOSE 6379
VOLUME /data
WORKDIR /data

ENTRYPOINT ["/entrypoint.sh"]
CMD [ "redis-server" ]
