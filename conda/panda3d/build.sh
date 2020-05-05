#!/bin/bash

PYTHON_VERSION=python3.8

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

python makepanda/makepanda.py \
    --bullet-incdir ${CONDA_PREFIX}/include \
    --bullet-libdir ${CONDA_PREFIX}/lib \
    --freetype-incdir ${CONDA_PREFIX}/include \
    --freetype-libdir ${CONDA_PREFIX}/lib \
    --openssl-incdir ${CONDA_PREFIX}/include \
    --openssl-libdir ${CONDA_PREFIX}/lib \
    --png-incdir ${CONDA_PREFIX}/include \
    --png-libdir ${CONDA_PREFIX}/lib \
    --python-incdir ${CONDA_PREFIX}/include \
    --python-libdir ${CONDA_PREFIX}/lib \
    --vorbis-incdir ${CONDA_PREFIX}/include \
    --vorbis-libdir ${CONDA_PREFIX}/lib \
    --zlib-incdir ${CONDA_PREFIX}/include \
    --zlib-libdir ${CONDA_PREFIX}/lib \
    --nothing \
    --outputdir ${BUILT} \
    --threads=2 \
    --use-bullet \
    --use-contrib \
    --use-deploytools \
    --use-direct \
    --use-egg \
    --use-freetype \
    --use-gl \
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
    --outputdir ${BUILT} \
    --verbose

# cmake \
#     -DCMAKE_BUILD_TYPE=Release \
#     -DCMAKE_INSTALL_PREFIX=${PREFIX} \
#     .
# make
# make install

cp -Rfv ${BUILT}/bin ${PREFIX}
cp -Rfv ${BUILT}/etc ${PREFIX}
cp -Rfv ${BUILT}/lib ${PREFIX}

mkdir -pv ${PREFIX}/include
cp -Rfv ${BUILT}/include                  ${PREFIX}/include/panda3d

mkdir -pv ${PREFIX}/share/panda3d
cp -Rfv ${BUILT}/models                   ${PREFIX}/share/panda3d

mkdir -pv ${PREFIX}/lib/${PYTHON_VERSION}/site-packages
cp -Rfv ${BUILT}/direct                   ${PREFIX}/lib/${PYTHON_VERSION}/site-packages
cp -Rfv ${BUILT}/panda3d                  ${PREFIX}/lib/${PYTHON_VERSION}/site-packages
cp -Rfv ${BUILT}/panda3d.dist-info        ${PREFIX}/lib/${PYTHON_VERSION}/site-packages
cp -Rfv ${BUILT}/pandac                   ${PREFIX}/lib/${PYTHON_VERSION}/site-packages
