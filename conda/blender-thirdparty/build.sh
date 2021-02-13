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
make osd_static_CPU
make osd_static_GPU
make install
cd ../..
# rm -f ${THIRDPARTY}/lib/libosdCPU.so*
# rm -f ${THIRDPARTY}/lib/libosdGPU.so*
