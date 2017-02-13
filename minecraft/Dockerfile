# minecraft spigot server container

FROM debian:jessie
MAINTAINER Brett Vickers

RUN set -x \
	&& apt-get update \
	&& apt-get install -y wget git openjdk-7-jre \
	&& mkdir -p /tmp/install \
	&& cd /tmp/install \
	&& wget -q https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar \
	&& java -jar BuildTools.jar \
	&& mkdir /spigot \
	&& cp spigot-1.10.2.jar /spigot \
	&& /* UPDATE /spigot/eula.txt */

CMD ["/bin/bash"]
