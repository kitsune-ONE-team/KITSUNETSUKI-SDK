#!/bin/bash

PYTHON_VERSION=python3.8

if [ "${ARCH}" = "64" ]; then
    LARCH=x86_64;
else
    LARCH=i386;
fi

LIBX=/lib/${LARCH}-linux-gnu;
ULIBX=/usr/lib/${LARCH}-linux-gnu;

BUILT=${SRC_DIR}/built;

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
    --zlib-incdir ${CONDA_PREFIX}/include \
    --zlib-libdir ${CONDA_PREFIX}/lib \
    --nothing \
    --threads=2 \
    --use-bullet \
    --use-contrib \
    --use-deploytools \
    --use-direct \
    --use-egg \
    --use-freetype \
    --use-gl \
    --use-nvidiacg \
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

# cmake \
#     -DCMAKE_BUILD_TYPE=Release \
#     -DCMAKE_INSTALL_PREFIX=${PREFIX} \
#     .
# make
# make install

cp -R ${BUILT}/bin ${PREFIX}
cp -R ${BUILT}/etc ${PREFIX}
cp -R ${BUILT}/lib ${PREFIX}

mkdir -p ${PREFIX}/include
cp -R ${BUILT}/include ${PREFIX}/include/panda3d

mkdir -p ${PREFIX}/share/panda3d
cp -R ${BUILT}/models ${PREFIX}/share/panda3d

mkdir -p ${PREFIX}/lib/${PYTHON_VERSION}/site-packages
cp -R ${BUILT}/direct ${PREFIX}/lib/${PYTHON_VERSION}/site-packages
cp -R ${BUILT}/panda3d ${PREFIX}/lib/${PYTHON_VERSION}/site-packages
cp -R ${BUILT}/pandac ${PREFIX}/lib/${PYTHON_VERSION}/site-packages
