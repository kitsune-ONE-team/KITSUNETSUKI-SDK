#!/bin/sh

THIRDPARTY=${PREFIX}/blender-thirdparty

cd openexr
cmake \
    -DOPENEXR_BUILD_PYTHON_LIBS=NO \
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

mkdir -p oiio/bld
cd oiio/bld
cmake \
    -DBOOST_ROOT=${THIRDPARTY} \
    -DBUILDSTATIC=1 \
    -DCMAKE_CXX_FLAGS=-fPIC \
    -DCMAKE_INSTALL_PREFIX=${THIRDPARTY} \
    -DILMBASE_HOME=${THIRDPARTY} \
    -DOIIO_BUILD_TESTS=OFF \
    -DOPENEXR_HOME=${THIRDPARTY} \
    -DUSE_FFMPEG=OFF \
    -DUSE_PYTHON=OFF \
    ..
make
make install
cd ../..
