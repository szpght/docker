# gcc cross-compiler container

FROM debian:jessie
MAINTAINER Brett Vickers

# Install cross-compiler prerequisites
RUN set -x \
	&& apt-get update \
	&& apt-get install -y wget gcc libgmp3-dev libmpfr-dev libisl-dev \
		libcloog-isl-dev libmpc-dev texinfo bison flex make bzip2 patch \
		build-essential

# Pull binutils and gcc source code
RUN set -x \
	&& mkdir -p /usr/local/src \
	&& cd /usr/local/src \
	&& wget -q ftp://ftp.gnu.org/gnu/binutils/binutils-2.26.tar.gz \
	&& wget -q ftp://ftp.gnu.org/gnu/gcc/gcc-6.2.0/gcc-6.2.0.tar.gz \
	&& tar zxf binutils-2.26.tar.gz \
	&& tar zxf gcc-6.2.0.tar.gz \
	&& rm binutils-2.26.tar.gz gcc-6.2.0.tar.gz \
	&& chown -R root:root binutils-2.26 \
	&& chown -R root:root gcc-6.2.0 \
	&& chmod -R o-w,g+w binutils-2.26 \
	&& chmod -R o-w,g+w gcc-6.2.0

# Copy compile scripts
COPY files/src /usr/local/src/

# Copy gcc patches
COPY files/gcc/t-x86_64-elf /usr/local/src/gcc-6.2.0/gcc/config/i386/
COPY files/gcc/config.gcc.patch /usr/local/src/gcc-6.2.0/gcc/

# Build and install binutils and the cross-compiler
RUN set -x \
	&& cd /usr/local/src \
	&& ./build-binutils.sh \
	&& ./build-gcc.sh

CMD ["/bin/bash"]
