#!/bin/sh

THIRDPARTY=${CONDA_PREFIX}/blender-thirdparty

cd blender

# build_files/build_environment/install_deps.sh \
#     --no-confirm \
#     --with-all

mkdir bld
cd bld
cmake \
    -DBOOST_ROOT=${THIRDPARTY} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_FLAGS="-std=gnu++11 -fPIC" \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DOPENEXR_ROOT_DIR=${THIRDPARTY} \
    -DOPENIMAGEIO_ROOT_DIR=${THIRDPARTY} \
    -DPYTHON_INCLUDE_DIR=${CONDA_PREFIX}/include/python3.7m \
    -DPYTHON_LIBRARY=${CONDA_PREFIX}/lib/libpython3.7m.so \
    -DPYTHON_VERSION=3.7 \
    -DWITH_AUDASPACE=OFF \
    -DWITH_CYCLES=ON \
    -DWITH_GLEW_ES=OFF \
    -DWITH_GLEW_MX=OFF \
    -DWITH_GLU=OFF \
    -DWITH_INSTALL_PORTABLE=OFF \
    -DWITH_OPENCOLLADA=OFF \
    -DWITH_PYTHON_INSTALL=OFF \
    -DWITH_PYTHON_INSTALL_NUMPY=OFF \
    -DWITH_PYTHON_MODULE=ON \
    -DWITH_STATIC_LIBS=ON \
    ..
make
make install
