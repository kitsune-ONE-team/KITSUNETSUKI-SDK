#!/bin/sh

# GCC 9.3+ required
# if [ ! -d lib/linux_centos7_x86_64 ]; then
#     mkdir lib
#     cd lib
#     svn checkout https://svn.blender.org/svnroot/bf-blender/trunk/lib/linux_centos7_x86_64
#     cd ..
# fi

THIRDPARTY=${CONDA_PREFIX}/blender-thirdparty

mkdir -p blender/bld

cd blender
rm -Rf release/scripts/addons
cp -Rf ../blender_extras/release/scripts/addons release/scripts/
rm -Rf release/scripts/addons_contrib
cp -Rf ../blender_extras/release/scripts/addons_contrib release/scripts/
rm -Rf release/datafiles/locale
cp -Rf ../blender_extras/release/datafiles/locale release/datafiles/
rm -Rf source/tools
cp -Rf ../blender_extras/source/tools source/

cd bld
cmake \
    -DBOOST_ROOT=${THIRDPARTY} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_FLAGS="-std=gnu++17" \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DOPENEXR_ROOT_DIR=${THIRDPARTY} \
    -DOPENIMAGEIO_ROOT_DIR=${THIRDPARTY} \
    -DPYTHON_INCLUDE_DIR=${CONDA_PREFIX}/include/python3.8 \
    -DPYTHON_LIBRARY=${CONDA_PREFIX}/lib/libpython3.8.so \
    -DPYTHON_VERSION=3.8 \
    -DWITH_AUDASPACE=OFF \
    -DWITH_CODEC_FFMPEG=OFF \
    -DWITH_CYCLES=ON \
    -DWITH_CYCLES_EMBREE=OFF \
    -DWITH_DRACO=OFF \
    -DWITH_GLEW_ES=OFF \
    -DWITH_GLEW_MX=OFF \
    -DWITH_GLU=OFF \
    -DWITH_HEADLESS=ON \
    -DWITH_INSTALL_PORTABLE=OFF \
    -DWITH_JACK=OFF \
    -DWITH_LLVM=OFF \
    -DWITH_MOD_OCEANSIM=OFF \
    -DWITH_OPENAL=OFF \
    -DWITH_OPENCOLLADA=OFF \
    -DWITH_OPENCOLORIO=OFF \
    -DWITH_OPENIMAGEDENOISE=OFF \
    -DWITH_OPENMP=OFF \
    -DWITH_OPENSUBDIV=OFF \
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

cp -fv ${CONDA_PREFIX}/blender-thirdparty/lib/libIex-2_3.so.24 ${PREFIX}/lib/
cp -fv ${CONDA_PREFIX}/blender-thirdparty/lib/libHalf-2_3.so.24 ${PREFIX}/lib/
cp -fv ${CONDA_PREFIX}/blender-thirdparty/lib/libIlmImf-2_3.so.24 ${PREFIX}/lib/
cp -fv ${CONDA_PREFIX}/blender-thirdparty/lib/libIlmThread-2_3.so.24 ${PREFIX}/lib/
