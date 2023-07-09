#!/bin/sh
THIRDPARTY=lib/linux_x86_64_glibc_228
PYTHON_VERSION=3.10

# remove included python
rm -Rf ${THIRDPARTY}/python

mkdir -p blender/bld
cd blender/bld
CMAKE_ARGS=
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_FIND_ROOT_PATH="${PREFIX};${PREFIX}/x86_64-conda-linux-gnu/sysroot;${PREFIX}/x86_64-conda_cos6-linux-gnu/sysroot;/usr;/usr/lib/x86_64-linux-gnu" \
    -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
    -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DCMAKE_LINKER=${PREFIX}/bin/x86_64-conda-linux-gnu-ld \
    -DCMAKE_STRIP=${PREFIX}/bin/x86_64-conda-linux-gnu-strip \
    -DBoost_INCLUDE_DIR=${THIRDPARTY}/boost/include \
    -DBOOST_LIBPATH=${THIRDPARTY}/boost/lib \
    -DBROTLI_INCLUDE_DIR=${THIRDPARTY}/brotli/include \
    -DBROTLI_LIBRARY_COMMON=${THIRDPARTY}/brotli/lib/libbrotlicommon-static.a \
    -DBROTLI_LIBRARY_DEC=${THIRDPARTY}/brotli/lib/libbrotlienc-static.a \
    -DEpoxy_INCLUDE_DIR=${THIRDPARTY}/epoxy/include \
    -DEpoxy_LIBRARY=${THIRDPARTY}/epoxy/lib/libepoxy.a \
    -DFREETYPE_INCLUDE_DIRS=${THIRDPARTY}/freetype/include \
    -DFREETYPE_LIBRARY=${THIRDPARTY}/freetype/lib/libfreetype.a \
    -DJPEG_INCLUDE_DIR=${THIRDPARTY}/jpeg/include \
    -DJPEG_LIBRARY=${THIRDPARTY}/jpeg/lib/libjpeg.a \
    -DOPENAL_LIBRARY=${THIRDPARTY}/openal/lib/libopenal.a \
    -DOPENEXR_INCLUDE_DIR=${THIRDPARTY}/openexr/include \
    -DOPENEXR_LIBPATH=${THIRDPARTY}/openexr/lib \
    -DOPENIMAGEIO_INCLUDE_DIR=${THIRDPARTY}/openimageio/include \
    -DOPENIMAGEIO_LIBPATH=${THIRDPARTY}/openimageio/lib \
    -DPNG_INCLUDE_DIR=${THIRDPARTY}/png/include \
    -DPNG_LIBRARY=${THIRDPARTY}/png/lib/libpng.a \
    -DPNG_PNG_INCLUDE_DIR=${THIRDPARTY}/png/include \
    -DPYTHON_INCLUDE_DIR=${CONDA_PREFIX}/include/python${PYTHON_VERSION} \
    -DPYTHON_LIBRARY=${CONDA_PREFIX}/lib/libpython${PYTHON_VERSION}.so \
    -DPYTHON_VERSION=${PYTHON_VERSION} \
    -DSDL2_INCLUDE_DIR=${THIRDPARTY}/sdl/include \
    -DSDL2_LIBRARY=${THIRDPARTY}/sdl/lib/libSDL2.a \
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
    -DWITH_FREETYPE=OFF \
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
    -DWITH_SYSTEM_FREETYPE=ON \
    -DWITH_TBB=ON \
    -DWITH_X11_XINPUT=ON \
    -D_LEVEL_ZERO_INCLUDE_DIR=${THIRDPARTY}/level-zero/include \
    -D_LEVEL_ZERO_LIBRARY=${THIRDPARTY}/level-zero/lib \
    ..

make
make install

cd ../..

cp -fv ${THIRDPARTY}/level-zero/lib/*.so.* ${PREFIX}/lib/
