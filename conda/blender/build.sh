#!/bin/sh

THIRDPARTY=${CONDA_PREFIX}/blender-thirdparty

mkdir -p blender/bld

cd blender

rm -Rf release/scripts/addons
rm -Rf release/scripts/addons_contrib
rm -Rf release/datafiles/locale
rm -Rf source/tools

cp -Rf ../blender_extras/release/scripts/addons release/scripts/
cp -Rf ../blender_extras/release/scripts/addons_contrib release/scripts/
cp -Rf ../blender_extras/release/datafiles/locale release/datafiles/
cp -Rf ../blender_extras/source/tools source/

cd bld
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DPYTHON_INCLUDE_DIR=${CONDA_PREFIX}/include/python3.9 \
    -DPYTHON_LIBRARY=${CONDA_PREFIX}/lib/libpython3.9.so \
    -DPYTHON_VERSION=3.9 \
    -DWITH_AUDASPACE=OFF \
    -DWITH_CODEC_FFMPEG=OFF \
    -DWITH_CYCLES=OFF \
    -DWITH_CYCLES_EMBREE=OFF \
    -DWITH_DRACO=OFF \
    -DWITH_FREESTYLE=OFF \
    -DWITH_GLEW_ES=OFF \
    -DWITH_GLEW_MX=OFF \
    -DWITH_GLU=OFF \
    -DWITH_HEADLESS=ON \
    -DWITH_INSTALL_PORTABLE=OFF \
    -DWITH_JACK=OFF \
    -DWITH_LLVM=OFF \
    -DWITH_MEM_JEMALLOC=OFF \
    -DWITH_MOD_OCEANSIM=OFF \
    -DWITH_OPENAL=OFF \
    -DWITH_OPENCOLLADA=OFF \
    -DWITH_OPENCOLORIO=OFF \
    -DWITH_OPENIMAGEDENOISE=OFF \
    -DWITH_OPENIMAGEIO=ON \
    -DWITH_OPENMP=OFF \
    -DWITH_OPENSUBDIV=ON \
    -DWITH_PYTHON_INSTALL=OFF \
    -DWITH_PYTHON_INSTALL_NUMPY=OFF \
    -DWITH_PYTHON_MODULE=ON \
    -DWITH_SDL=OFF \
    -DWITH_STATIC_LIBS=OFF \
    -DWITH_TBB=OFF \
    -DWITH_X11_XINPUT=OFF \
    ..

make
make install

cd ..

# cp -fv ${CONDA_PREFIX}/blender-thirdparty/lib/libOpenImageIO* ${PREFIX}/lib/
