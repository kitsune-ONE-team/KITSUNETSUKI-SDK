#!/bin/sh

PYTHON_VERSION=3.10

mkdir -p bld

cd bld
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=${PREFIX}/lib/python${PYTHON_VERSION}/site-packages \
    -DINSTALL_PY=ON \
    ..

make
make install

cd ..
