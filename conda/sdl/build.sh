#!/bin/sh

mkdir -p bld
cd bld
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    ..

make
make install

cd ..
