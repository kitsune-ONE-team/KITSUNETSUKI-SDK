#!/bin/sh

mkdir -p bld
cd bld
cmake \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_GLSL_EXTENSIONS=OFF \
    -DBUILD_LEGACY_LIVE_TEST=OFF \
    -DBUILD_NETWORK_DEVICE=OFF \
    -DBUILD_PYTHON_BINDINGS=ON \
    -DBUILD_UNIT_TESTS=OFF \
    -DBUILD_WITH_TM2=OFF \
    -DCMAKE_BUILD_TYPE=Release \
    -DUSE_EXTERNAL_USB=OFF \
    -DLIBUSB_INC=/usr/include \
    ..

make
make install

cd ..
