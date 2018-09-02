FROM debian:stretch
WORKDIR /app

RUN set -x \
    && apt-get update \
    && apt-get install -y default-jre wget

RUN set -x \
    && wget --no-check-certificate -q https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.tar.gz \
    && tar zxf dynamodb_local_latest.tar.gz \
    && rm dynamodb_local_latest.tar.gz

COPY docker-entrypoint.sh ./

RUN set -x \
    && chmod 755 docker-entrypoint.sh \
    && mkdir db

VOLUME /app/db

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["start"]
