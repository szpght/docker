# nginx container

FROM alpine
LABEL maintainer "Brett Vickers <github.com/beevik>"

RUN apk update && apk add bash nginx

# forward request and error logs to docker log collector
RUN set -x \
	&& ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
