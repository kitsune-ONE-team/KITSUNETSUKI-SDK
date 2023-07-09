#!/bin/sh
THIRDPARTY=lib/linux_x86_64_glibc_228
PYTHON_VERSION=3.10

# remove included python
rm -Rf ${THIRDPARTY}/python

mkdir -p blender/bld

CMAKE_ARGS=

cd blender/bld
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_FIND_ROOT_PATH="${PREFIX};${PREFIX}/x86_64-conda-linux-gnu/sysroot;/usr;/usr/lib/x86_64-linux-gnu" \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DCMAKE_LINKER=${PREFIX}/bin/x86_64-conda-linux-gnu-ld \
    -DCMAKE_STRIP=${PREFIX}/bin/x86_64-conda-linux-gnu-strip \
    -DPYTHON_INCLUDE_DIR=${CONDA_PREFIX}/include/python${PYTHON_VERSION} \
    -DPYTHON_LIBRARY=${CONDA_PREFIX}/lib/libpython${PYTHON_VERSION}.so \
    -DPYTHON_VERSION=${PYTHON_VERSION} \
    -DWITH_AUDASPACE=ON \
    -DWITH_CODEC_AVI=ON \
    -DWITH_CODEC_FFMPEG=ON \
    -DWITH_CODEC_SNDFILE=ON \
    -DWITH_CYCLES=ON \
    -DWITH_CYCLES_EMBREE=ON \
    -DWITH_DRACO=ON \
    -DWITH_FREESTYLE=ON \
    -DWITH_HEADLESS=ON \
    -DWITH_INSTALL_PORTABLE=OFF \
    -DWITH_JACK=ON \
    -DWITH_LLVM=OFF \
    -DWITH_MEM_JEMALLOC=OFF \
    -DWITH_MOD_OCEANSIM=ON \
    -DWITH_OPENAL=ON \
    -DWITH_OPENCOLLADA=ON \
    -DWITH_OPENCOLORIO=ON \
    -DWITH_OPENIMAGEDENOISE=ON \
    -DWITH_OPENIMAGEIO=ON \
    -DWITH_OPENMP=ON \
    -DWITH_OPENSUBDIV=ON \
    -DWITH_PYTHON_INSTALL=OFF \
    -DWITH_PYTHON_INSTALL_NUMPY=OFF \
    -DWITH_PYTHON_MODULE=ON \
    -DWITH_SDL=ON \
    -DWITH_TBB=ON \
    -DWITH_X11_XINPUT=ON \
    ..

make
make install

cd ../..

cp -fv ${THIRDPARTY}/level-zero/lib/*.so.* ${PREFIX}/lib/
