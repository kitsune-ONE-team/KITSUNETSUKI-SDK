#!/bin/sh

PYTHON_VERSION=python3.9

cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=${PREFIX}/lib/${PYTHON_VERSION}/site-packages \
    .

make
make install
