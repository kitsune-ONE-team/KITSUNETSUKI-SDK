#!/bin/sh

PYTHON_VERSION=python3.9

mkdir -p bld

cd bld
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=${PREFIX}/lib/${PYTHON_VERSION}/site-packages \
    ..

make
make install

cd ..
