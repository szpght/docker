FROM debian:jessie
WORKDIR /app

COPY docker-entrypoint.sh ./

RUN set -x \
    && chmod 755 docker-entrypoint.sh \
    && apt-get update \
    && apt-get install -y default-jre wget \
    && wget -q --no-check-certificate https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.tar.gz \
    && tar zxf dynamodb_local_latest.tar.gz \
    && rm dynamodb_local_latest.tar.gz

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["start"]
