#!/bin/sh

cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=${PREFIX}/lib/python3.7/site-packages

make
make install
