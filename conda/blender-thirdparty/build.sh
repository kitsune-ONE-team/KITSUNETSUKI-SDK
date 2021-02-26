#!/bin/sh

THIRDPARTY=${PREFIX}/blender-thirdparty

cd boost
./bootstrap.sh \
    --prefix=${THIRDPARTY} \
    --without-libraries=python
./b2 install cxxflags='-fPIC' link=static
cd ..

cd openexr
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=${THIRDPARTY} \
    -DOPENEXR_BUILD_PYTHON_LIBS=NO \
    -DBUILD_SHARED_LIBS=OFF \
    -DBUILD_TESTING=OFF \
    -DCMAKE_CXX_FLAGS=-fPIC \
    .
make
make install
cd ..

mkdir -p oiio/bld
cd oiio/bld
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=${THIRDPARTY} \
    -DBOOST_ROOT=${THIRDPARTY} \
    -DBUILDSTATIC=1 \
    -DCMAKE_CXX_FLAGS=-fPIC \
    -DILMBASE_HOME=${THIRDPARTY} \
    -DOIIO_BUILD_TESTS=OFF \
    -DOPENEXR_HOME=${THIRDPARTY} \
    -DUSE_FFMPEG=OFF \
    -DUSE_PYTHON=OFF \
    -DBUILDSTATIC=1 \
    ..
make
make install
cd ../..

mkdir -p clew/bld
cd clew/bld
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=${THIRDPARTY} \
    -DBUILD_TESTS=OFF \
    -DBUILD_SHARED_LIBRARY=OFF \
    ..
make
make install
cd ../..

mkdir -p OpenSubdiv/bld
cd OpenSubdiv/bld
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=${THIRDPARTY} \
    -DCLEW_LOCATION=${THIRDPARTY} \
    -DNO_CUDA=1 \
    -DNO_DOC=1 \
    -DNO_EXAMPLES=1 \
    -DNO_OMP=1 \
    -DNO_OPENGL=1 \
    -DNO_PTEX=1 \
    -DNO_TBB=1 \
    -DNO_TUTORIALS=1 \
    ..
make
make install
cd ../..
rm -f ${THIRDPARTY}/lib/libosdCPU.so*
rm -f ${THIRDPARTY}/lib/libosdGPU.so*
