#!/bin/bash
THIRDPARTY=lib/linux_x86_64_glibc_228
PYTHON_VERSION=3.10

python ${RECIPE_DIR}/icon.py \
    ${RECIPE_DIR}/icon_256.png \
    panda/src/x11display/icon.h

mkdir bld
cd bld

# CMAKE_ARGS=
# cmake \
#     -DCMAKE_BUILD_TYPE=Standard \
#     -DCMAKE_FIND_ROOT_PATH="${PREFIX};${PREFIX}/x86_64-conda-linux-gnu/sysroot;${PREFIX}/x86_64-conda_cos6-linux-gnu/sysroot;/usr;/usr/lib/x86_64-linux-gnu" \
#     -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
#     -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
#     -DCMAKE_INSTALL_LIBDIR=lib \
#     -DCMAKE_INSTALL_PREFIX=${PREFIX} \
#     -DBUILD_CONTRIB=ON \
#     -DBUILD_DIRECT=ON \
#     -DBUILD_DTOOL=ON \
#     -DBUILD_METALIBS=ON \
#     -DBUILD_MODELS=ON \
#     -DBUILD_PANDA=ON \
#     -DBUILD_PANDATOOL=ON \
#     -DCMAKE_CXX_FLAGS="-fno-rtti" \
#     ..

# make
# make install

# cd ..

# copy missing includes
# cp -Rfv dtool/src/parser-inc                      ${PREFIX}/include/panda3d/

# copy dist-info for pip
# cp -Rfv ${BUILT}/panda3d.dist-info                 ${PREFIX}/lib/python${PYTHON_VERSION}/site-packages/

python makepanda/makepanda.py \
    --bullet-incdir ${CONDA_PREFIX}/include \
    --bullet-libdir ${CONDA_PREFIX}/lib \
    --freetype-incdir ${THIRDPARTY}/include \
    --freetype-libdir ${THIRDPARTY}/lib \
    --jpeg-incdir ${THIRDPARTY}/include \
    --jpeg-libdir ${THIRDPARTY}/lib \
    --openssl-incdir ${CONDA_PREFIX}/include \
    --openssl-libdir ${CONDA_PREFIX}/lib \
    --png-incdir ${THIRDPARTY}/include \
    --png-libdir ${THIRDPARTY}/lib \
    --python-incdir ${CONDA_PREFIX}/include \
    --python-libdir ${CONDA_PREFIX}/lib \
    --vorbis-incdir ${CONDA_PREFIX}/include \
    --vorbis-libdir ${CONDA_PREFIX}/lib \
    --zlib-incdir ${CONDA_PREFIX}/include \
    --zlib-libdir ${CONDA_PREFIX}/lib \
    --nothing \
    --outputdir bld \
    --threads=2 \
    --use-bullet \
    --use-contrib \
    --use-deploytools \
    --use-direct \
    --use-egg \
    --use-freetype \
    --use-gl \
    --use-harfbuzz \
    --use-openal \
    --use-openssl \
    --use-pandafx \
    --use-pandaparticlesystem \
    --use-pandaphysics \
    --use-pandatool \
    --use-png \
    --use-pview \
    --use-python \
    --use-skel \
    --use-vorbis \
    --use-x11 \
    --use-zlib \
    --verbose

python makepanda/makewheel.py \
    --outputdir bld \
    --verbose

cp -Rfv bld/bin ${PREFIX}
cp -Rfv bld/etc ${PREFIX}
cp -Rfv bld/lib ${PREFIX}

mkdir -pv ${PREFIX}/include
cp -Rfv bld/include                  ${PREFIX}/include/panda3d

mkdir -pv ${PREFIX}/share/panda3d
cp -Rfv bld/models                   ${PREFIX}/share/panda3d

mkdir -pv ${PREFIX}/lib/python${PYTHON_VERSION}/site-packages
cp -Rfv bld/direct                   ${PREFIX}/lib/python${PYTHON_VERSION}/site-packages
cp -Rfv bld/panda3d                  ${PREFIX}/lib/python${PYTHON_VERSION}/site-packages
cp -Rfv bld/panda3d.dist-info        ${PREFIX}/lib/python${PYTHON_VERSION}/site-packages
cp -Rfv bld/pandac                   ${PREFIX}/lib/python${PYTHON_VERSION}/site-packages
