#!/bin/bash

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
    --nothing \
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
    --threads=2 \
    --verbose \
    --python-incdir ${CONDA_PREFIX}/include \
    --python-libdir ${CONDA_PREFIX}/lib \
    --openssl-incdir ${CONDA_PREFIX}/include \
    --openssl-libdir ${CONDA_PREFIX}/lib \
    --bullet-incdir ${CONDA_PREFIX}/include \
    --bullet-libdir ${CONDA_PREFIX}/lib

cp -R ${BUILT}/bin ${PREFIX}
cp -R ${BUILT}/etc ${PREFIX}
cp -R ${BUILT}/lib ${PREFIX}

# cp -fv ${ULIBX}/libCg.so           ${PREFIX}/lib/;
# cp -fv ${ULIBX}/libCgGL.so         ${PREFIX}/lib/;
# cp -fv ${ULIBX}/libogg.so.0        ${PREFIX}/lib/;
# cp -fv ${ULIBX}/libopenal.so.1     ${PREFIX}/lib/;
# cp -fv ${ULIBX}/libvorbis.so.0     ${PREFIX}/lib/;
# cp -fv ${ULIBX}/libvorbisfile.so.3 ${PREFIX}/lib/;

mkdir -p ${PREFIX}/include
cp -R ${BUILT}/include ${PREFIX}/include/panda3d

mkdir -p ${PREFIX}/share/panda3d
cp -R ${BUILT}/models ${PREFIX}/share/panda3d

mkdir -p ${PREFIX}/lib/python3.7/site-packages
cp -R ${BUILT}/direct ${PREFIX}/lib/python3.7/site-packages
cp -R ${BUILT}/panda3d ${PREFIX}/lib/python3.7/site-packages
cp -R ${BUILT}/pandac ${PREFIX}/lib/python3.7/site-packages
