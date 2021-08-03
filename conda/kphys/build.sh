#!/bin/sh

PYTHON_VERSION=python3.8

cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=${PREFIX}/lib/${PYTHON_VERSION}/site-packages \
    .

make
make install
