#!/bin/sh

mkdir -p bld
cd bld
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DSDL_LIBC=OFF \
    -DSDL_OSS=OFF \
    -DSDL_SHARED=ON \
    -DSDL_STATIC=ON \
    -DSDL_STATIC_PIC=ON \
    ..

make
make install

cd ..
