FROM debian:jessie

# ----------------
# Install Postgres
# ----------------

# explicitly set user/group IDs
RUN set -x \
	&& groupadd -r gogs --gid=1000 \
	&& adduser --disabled-password --gecos 'Gogs' --uid 1000 --ingroup gogs gogs

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.7
RUN set -x \
	&& sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends ca-certificates git wget locales sudo git openssh-server \
	&& wget -q -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -q -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true \
	&& rm -rf /var/lib/apt/lists/*

# make the "en_US.UTF-8" locale so postgres will be utf-8 enabled by default
RUN set -x \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

ENV PG_MAJOR 9.5

RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main' $PG_MAJOR > /etc/apt/sources.list.d/pgdg.list

RUN set -x \
	&& apt-get update \
	&& apt-get install -y postgresql-common \
	&& sed -ri 's/#(create_main_cluster) .*$/\1 = false/' /etc/postgresql-common/createcluster.conf \
	&& apt-get install -y \
		postgresql-$PG_MAJOR \
		postgresql-contrib-$PG_MAJOR \
	&& rm -rf /var/lib/apt/lists/*

# make the sample config easier to munge (and "correct by default")
RUN set -x \
	&& mv -v /usr/share/postgresql/$PG_MAJOR/postgresql.conf.sample /usr/share/postgresql/ \
	&& ln -sv ../postgresql.conf.sample /usr/share/postgresql/$PG_MAJOR/ \
	&& sed -ri "s@^#?(listen_addresses)\s*=\s*\S+.*@#\1 = '*'@" /usr/share/postgresql/postgresql.conf.sample

RUN set -x \
	&& mkdir -p /var/run/postgresql \
	&& chown -R gogs:gogs /var/run/postgresql

ENV PATH /usr/lib/postgresql/$PG_MAJOR/bin:$PATH
ENV PGDATA /var/lib/postgresql/data


# ------------
# Install gogs
# ------------

RUN set -x \
    && cd /tmp \
    && wget -q https://dl.gogs.io/gogs_v0.9.141_linux_amd64.tar.gz \
    && tar -C /usr/local -xzf /tmp/gogs_v0.9.141_linux_amd64.tar.gz \
    && rm /tmp/gogs_v0.9.141_linux_amd64.tar.gz \
    && mkdir -p /var/lib/gogs /var/log/gogs \
    && chown -R gogs:gogs /usr/local/gogs /var/lib/gogs /var/log/gogs

COPY files/launch.sh /usr/local/gogs/launch.sh


# ------------
# Install sshd
# ------------

RUN set -x \
	&& mkdir -p /var/run/sshd \
	&& chmod 700 /var/run/sshd \
	&& sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config \
	&& sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd


# ----------------
# Complete install
# ----------------

COPY files/docker-entrypoint.sh /docker-entrypoint.sh

RUN set -x \
	&& chmod 700 /docker-entrypoint.sh \
	&& chown gogs:gogs /usr/local/gogs/launch.sh \
	&& chmod 775 /usr/local/gogs/launch.sh

VOLUME /var/lib/postgresql/data
VOLUME /var/lib/gogs

EXPOSE 22 3000

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["start"]
