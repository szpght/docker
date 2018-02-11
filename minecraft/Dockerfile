# minecraft spigot server container

FROM debian:jessie
LABEL maintainer "Brett Vickers <github.com/beevik>"

RUN set -x \
	&& apt-get update \
	&& apt-get install -y wget git openjdk-7-jre \
	&& mkdir -p /tmp/install \
	&& cd /tmp/install \
	&& wget -q https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar \
	&& java -jar BuildTools.jar \
	&& mkdir /spigot \
	&& cp spigot-1.11.2.jar /spigot

CMD ["/bin/bash"]
