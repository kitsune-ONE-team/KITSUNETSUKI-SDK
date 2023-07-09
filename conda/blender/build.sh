#!/bin/sh
THIRDPARTY=lib/linux_x86_64_glibc_228
PYTHON_VERSION=3.10

# remove included python
rm -Rf ${THIRDPARTY}/python

mkdir -p blender/bld

CMAKE_ARGS=
# CFLAGS="${CFLAGS} -I/usr/include"
# CPPFLAGS="${CPPFLAGS} -I/usr/include"
# echo FLAGS:
# echo ${CFLAGS}
# echo ${CPPFLAGS}

cd blender/bld
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_FIND_ROOT_PATH="${PREFIX};${PREFIX}/x86_64-conda-linux-gnu/sysroot;${PREFIX}/x86_64-conda_cos6-linux-gnu/sysroot;/usr;/usr/lib/x86_64-linux-gnu" \
    -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
    -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DCMAKE_LINKER=${PREFIX}/bin/x86_64-conda-linux-gnu-ld \
    -DCMAKE_STRIP=${PREFIX}/bin/x86_64-conda-linux-gnu-strip \
    -DEpoxy_INCLUDE_DIR=${THIRDPARTY}/epoxy/include \
    -DEpoxy_LIBRARY=${THIRDPARTY}/epoxy/lib/libepoxy.a \
    -DJPEG_INCLUDE_DIR=${THIRDPARTY}/jpeg/include \
    -DJPEG_LIBRARY=${THIRDPARTY}/jpeg/lib/libjpeg.a \
    -DPNG_LIBRARY=${THIRDPARTY}/png/lib/libpng.a \
    -DPNG_PNG_INCLUDE_DIR=${THIRDPARTY}/png/include \
    -DPYTHON_INCLUDE_DIR=${CONDA_PREFIX}/include/python${PYTHON_VERSION} \
    -DPYTHON_LIBRARY=${CONDA_PREFIX}/lib/libpython${PYTHON_VERSION}.so \
    -DPYTHON_VERSION=${PYTHON_VERSION} \
    -DTIFF_INCLUDE_DIR=${THIRDPARTY}/tiff/include \
    -DTIFF_LIBRARY=${THIRDPARTY}/tiff/lib/libtiff.a \
    -DWITH_AUDASPACE=ON \
    -DWITH_CODEC_AVI=OFF \
    -DWITH_CODEC_FFMPEG=OFF \
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
    -D_LEVEL_ZERO_INCLUDE_DIR=${THIRDPARTY}/level-zero/include \
    -D_LEVEL_ZERO_LIBRARY=${THIRDPARTY}/level-zero/lib \
    ..

make
make install

cd ../..

cp -fv ${THIRDPARTY}/level-zero/lib/*.so.* ${PREFIX}/lib/
