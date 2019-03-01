#!/bin/bash

if [ "${ARCH}" = "64" ]; then
    INSTALL=${PREFIX}/runtime-lynx64;
    LARCH=x86_64;
else
    INSTALL=${PREFIX}/runtime-lynx32;
    LARCH=i386;
fi

# pip install -r ${RECIPE_DIR}/req.txt;
pip install https://files.pythonhosted.org/packages/75/d0/f213003c9deec99fb4f46e54580b93a3b121c487d9d6d888fc12267eb2a2/httplib2-0.12.1.tar.gz
pip install https://files.pythonhosted.org/packages/64/19/8b9066e94088e8d06d649e10319349bfca961e87768a525aba4a2627c986/oauth2-1.9.0.post1.tar.gz
pip install https://files.pythonhosted.org/packages/cd/e6/be1b2a6ebebdaf1f790f1e750bb720fbda0335c2a19601ea9d8bb5059f38/jsonschema-3.0.0-py2.py3-none-any.whl
pip install https://files.pythonhosted.org/packages/68/9c/a6c34e565351f0b04bcf6835e38bc4bd0647269dc48670e12eb99a3f5ef5/py-ubjson-0.12.0.tar.gz
pip install https://files.pythonhosted.org/packages/ad/13/eb56951b6f7950cadb579ca166e448ba77f9d24efc03edd7e55fa57d04b7/idna-2.8.tar.gz

mkdir -pv ${INSTALL}/kgame/lib/python3.7/site-packages/panda3d;
cp -fv ${CONDA_PREFIX}/lib/libpython3.7m.so.1.0   ${INSTALL}/kgame/lib/;
cp -fv ${CONDA_PREFIX}/lib/libcrypto.so.1.1       ${INSTALL}/kgame/lib/;
cp -fv ${CONDA_PREFIX}/lib/libssl.so.1.1          ${INSTALL}/kgame/lib/;
cp -fv ${CONDA_PREFIX}/lib/python3.7/os.py        ${INSTALL}/kgame/lib/python3.7/;
cp -Rfv ${CONDA_PREFIX}/lib/python3.7/lib-dynload ${INSTALL}/kgame/lib/python3.7/;

cp -fv \
   ${CONDA_PREFIX}/lib/python3.7/site-packages/panda3d/__init__.py \
   ${CONDA_PREFIX}/lib/python3.7/site-packages/panda3d/*.so \
                                                  ${INSTALL}/kgame/lib/python3.7/site-packages/panda3d/;
cp -fv ${CONDA_PREFIX}/lib/python3.7/site-packages/kcc.so \
                                                  ${INSTALL}/kgame/lib/python3.7/site-packages/;
cp -fv ${CONDA_PREFIX}/lib/python3.7/site-packages/httplib2/cacerts.txt \
                                                  ${INSTALL}/kgame/;

cp -fv ${RECIPE_DIR}/Miniconda3-LICENSE.txt       ${INSTALL}/kgame/;
cp -fv ${RECIPE_DIR}/oauth2-LICENSE.txt           ${INSTALL}/kgame/;
cp -fv ${RECIPE_DIR}/Panda3D-LICENSE.txt          ${INSTALL}/kgame/;
cp -fv ${RECIPE_DIR}/py-ubjson-LICENSE.txt        ${INSTALL}/kgame/;
cp -fv ${RECIPE_DIR}/py-ubjson-NOTICE.txt         ${INSTALL}/kgame/;
cp -fv ${RECIPE_DIR}/jsonschema-LICENSE.txt       ${INSTALL}/kgame/;

cp -fv ${CONDA_PREFIX}/lib/libCg.so               ${INSTALL}/kgame/lib/;
cp -fv ${CONDA_PREFIX}/lib/libCgGL.so             ${INSTALL}/kgame/lib/;
cp -fv ${CONDA_PREFIX}/lib/libfreetype.so.6       ${INSTALL}/kgame/lib/;
cp -fv ${CONDA_PREFIX}/lib/libogg.so.0            ${INSTALL}/kgame/lib/;
cp -fv ${CONDA_PREFIX}/lib/libopenal.so.1         ${INSTALL}/kgame/lib/;
cp -fv ${CONDA_PREFIX}/lib/libpng16.so.16         ${INSTALL}/kgame/lib/;
cp -fv ${CONDA_PREFIX}/lib/libvorbis.so.0         ${INSTALL}/kgame/lib/;
cp -fv ${CONDA_PREFIX}/lib/libvorbisfile.so.3     ${INSTALL}/kgame/lib/;
cp -fv \
   ${CONDA_PREFIX}/lib/libpanda*.so.1.10 \
   ${CONDA_PREFIX}/lib/libp3*.so.1.10 \
                                                  ${INSTALL}/kgame/lib/;
cp -fv ${CONDA_PREFIX}/lib/libp3openal_audio.so   ${INSTALL}/kgame/lib/;
cp -fv ${CONDA_PREFIX}/lib/libp3ptloader.so       ${INSTALL}/kgame/lib/;
cp -fv ${CONDA_PREFIX}/lib/libpandagl.so          ${INSTALL}/kgame/lib/;

7za a \
    -tzip -x@${RECIPE_DIR}/exclude.txt -xr@${RECIPE_DIR}/excluder.txt \
    ${INSTALL}/kgame/lib/python37.zip \
    "${CONDA_PREFIX}/lib/python3.7/*" \
    ${CONDA_PREFIX}/lib/python3.7/site-packages/direct \
    ${CONDA_PREFIX}/lib/python3.7/site-packages/httplib2 \
    ${CONDA_PREFIX}/lib/python3.7/site-packages/idna \
    ${CONDA_PREFIX}/lib/python3.7/site-packages/jsonschema \
    ${CONDA_PREFIX}/lib/python3.7/site-packages/oauth2 \
    ${CONDA_PREFIX}/lib/python3.7/site-packages/pandac \
    ${CONDA_PREFIX}/lib/python3.7/site-packages/ubjson;

pip uninstall --yes httplib2 jsonschema oauth2 py-ubjson idna;
