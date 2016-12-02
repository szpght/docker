#!/bin/bash

export PREFIX="/usr/local"
export TARGET=x86_64-elf
export PATH="$PREFIX/bin:$PATH"

cd $PREFIX/src/gcc-6.2.0/gcc
patch < config.gcc.patch

cd $PREFIX/src
mkdir build-gcc
cd build-gcc
../gcc-6.2.0/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
make -j 4 all-gcc
make -j 4 all-target-libgcc
make install-gcc
make install-target-libgcc

cd $PREFIX/src
rm -rf build-gcc.sh build-gcc gcc-6.2.0
