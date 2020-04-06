#!/bin/sh

THIRDPARTY=${PREFIX}/blender-thirdparty

cd openexr
cmake \
    -DBUILD_SHARED_LIBS=OFF \
    -DCMAKE_CXX_FLAGS=-fPIC \
    -DCMAKE_INSTALL_PREFIX=${THIRDPARTY} \
    .
make
make install
cd ..

cd boost
./bootstrap.sh \
    --prefix=${THIRDPARTY} \
    --without-libraries=python
./b2 install cxxflags='-fPIC' link=static
cd ..

mkdir oiio/bld
cd oiio/bld
cmake \
    -DBUILDSTATIC=1 \
    -DBOOST_ROOT=${THIRDPARTY} \
    -DILMBASE_HOME=${THIRDPARTY} \
    -DOPENEXR_HOME=${THIRDPARTY} \
    -DCMAKE_CXX_FLAGS=-fPIC \
    -DCMAKE_INSTALL_PREFIX=${THIRDPARTY} \
    -DUSE_FFMPEG=OFF \
    -DUSE_PYTHON=OFF \
    -DOIIO_BUILD_TESTS=OFF \
    ..
make
make install
cd ../..
