#!/bin/bash
PYTHON_VERSION=3.10

if [ "${ARCH}" = "64" ]; then
    LARCH=x86_64;
else
    LARCH=i386;
fi

LIBX=/lib/${LARCH}-linux-gnu
ULIBX=/usr/lib/${LARCH}-linux-gnu

BUILT=built

python ${RECIPE_DIR}/icon.py \
    ${RECIPE_DIR}/icon_256.png \
    panda/src/x11display/icon.h

mkdir -p ${BUILT}
cd ${BUILT}
cmake \
    -DCMAKE_BUILD_TYPE=Standard \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DBUILD_CONTRIB=ON \
    -DBUILD_DIRECT=ON \
    -DBUILD_DTOOL=ON \
    -DBUILD_METALIBS=ON \
    -DBUILD_MODELS=ON \
    -DBUILD_PANDA=ON \
    -DBUILD_PANDATOOL=ON \
    -DCMAKE_CXX_FLAGS="-fno-rtti" \
    ..

make
make install

cd ..

# copy missing includes
cp -Rfv dtool/src/parser-inc                      ${PREFIX}/include/panda3d/

# copy dist-info for pip
cp -Rfv ${BUILT}/panda3d.dist-info                 ${PREFIX}/lib/python${PYTHON_VERSION}/site-packages/
