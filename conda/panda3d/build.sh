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
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_DTOOL=ON \
    -DBUILD_PANDA=ON \
    -DBUILD_DIRECT=ON \
    -DBUILD_PANDATOOL=ON \
    -DBUILD_CONTRIB=ON \
    -DBUILD_MODELS=ON \
    ..

make
make install

cd ..

# copy missing includes
cp -Rfv dtool/src/parser-inc                      ${PREFIX}/include/panda3d/
cp -fv dtool/src/dtoolbase/patomic.h              ${PREFIX}/include/panda3d/
