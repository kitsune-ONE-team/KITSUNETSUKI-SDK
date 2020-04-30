#!/bin/bash

PANDA_VERSION=1.10
PYTHON_VERSION=python3.8
PYTHONVERSION=python38

if [ "${ARCH}" = "64" ]; then
    LARCH=x86_64;
else
    LARCH=i386;
fi

LIBX=/lib/${LARCH}-linux-gnu
ULIBX=/usr/lib/${LARCH}-linux-gnu

pip install https://files.pythonhosted.org/packages/23/96/d828354fa2dbdf216eaa7b7de0db692f12c234f7ef888cc14980ef40d1d2/attrs-19.1.0-py2.py3-none-any.whl
pip install https://files.pythonhosted.org/packages/64/19/8b9066e94088e8d06d649e10319349bfca961e87768a525aba4a2627c986/oauth2-1.9.0.post1.tar.gz
pip install https://files.pythonhosted.org/packages/68/9c/a6c34e565351f0b04bcf6835e38bc4bd0647269dc48670e12eb99a3f5ef5/py-ubjson-0.12.0.tar.gz
pip install https://files.pythonhosted.org/packages/75/d0/f213003c9deec99fb4f46e54580b93a3b121c487d9d6d888fc12267eb2a2/httplib2-0.12.1.tar.gz
pip install https://github.com/kitsune-ONE-team/RenderPipeline/releases/download/v1.3.1/render_pipeline-1.3.1-py3-none-any.whl

mkdir -pv ${PREFIX}/kitsunetsuki-runtime/panda3d;
cp -fv ${CONDA_PREFIX}/lib/lib${PYTHON_VERSION}m.so.1.0   ${PREFIX}/kitsunetsuki-runtime
cp -fv ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/os.py        ${PREFIX}/kitsunetsuki-runtime

cp -Rfv ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/lib-dynload ${PREFIX}/kitsunetsuki-runtime
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_bisect.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_bz2.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_codecs_*.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_crypt.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_csv.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_ctypes.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_ctypes_test.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_curses.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_curses_panel.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_heapq.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_lsprof.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_multibytecodec.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_opcode.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_pickle.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_sqlite3.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_testbuffer.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_testcapi.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_testimportmultiple.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_testmultiphase.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_tkinter.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_xxtestfuzz.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/audioop.cpython-*-linux-gnu.s
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/fcntl.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/grp.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/mmap.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/nis.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/ossaudiodev.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/parser.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/resource.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/spwd.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/syslog.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/termios.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/xxlimited.cpython-*-linux-gnu.so

cp -fv \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/panda3d/__init__.py \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/panda3d/*.so \
                                                  ${PREFIX}/kitsunetsuki-runtime/panda3d/
cp -fv \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/kcc.so \
                                                  ${PREFIX}/kitsunetsuki-runtime
cp -fv \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/httplib2/cacerts.txt \
                                                  ${PREFIX}/kitsunetsuki-runtime

cp -fv ${RECIPE_DIR}/Miniconda3-LICENSE.txt       ${PREFIX}/kitsunetsuki-runtime
cp -fv ${RECIPE_DIR}/Panda3D-LICENSE.txt          ${PREFIX}/kitsunetsuki-runtime
cp -fv ${RECIPE_DIR}/jsonschema-LICENSE.txt       ${PREFIX}/kitsunetsuki-runtime
cp -fv ${RECIPE_DIR}/oauth2-LICENSE.txt           ${PREFIX}/kitsunetsuki-runtime
cp -fv ${RECIPE_DIR}/py-ubjson-LICENSE.txt        ${PREFIX}/kitsunetsuki-runtime
cp -fv ${RECIPE_DIR}/py-ubjson-NOTICE.txt         ${PREFIX}/kitsunetsuki-runtime

cp -fv \
   ${ULIBX}/libCg.so \
   ${ULIBX}/libCgGL.so \
   ${ULIBX}/libogg.so.0 \
   ${ULIBX}/libopenal.so.1 \
   ${ULIBX}/libvorbis.so.0 \
                                                  ${PREFIX}/kitsunetsuki-runtime

cp -fv \
   ${CONDA_PREFIX}/lib/libcrypto.so.1.1 \
   ${CONDA_PREFIX}/lib/libgcc_s.so.1 \
   ${CONDA_PREFIX}/lib/libp3*.so.* \
   ${CONDA_PREFIX}/lib/libpanda*.so.* \
   ${CONDA_PREFIX}/lib/libpng16.so.16 \
   ${CONDA_PREFIX}/lib/libssl.so.1.1 \
   ${CONDA_PREFIX}/lib/libstdc++.so.6 \
   ${CONDA_PREFIX}/lib/libvorbisfile.so.3 \
   ${CONDA_PREFIX}/lib/libz.so.1 \
   ${CONDA_PREFIX}/lib/libp3openal_audio.so \
   ${CONDA_PREFIX}/lib/libp3ptloader.so \
   ${CONDA_PREFIX}/lib/libpandagl.so \
                                                  ${PREFIX}/kitsunetsuki-runtime

7za a \
    -tzip -x@${RECIPE_DIR}/exclude.txt -xr@${RECIPE_DIR}/excluder.txt \
    ${PREFIX}/kitsunetsuki-runtime/${PYTHONVERSION}.zip \
    "${CONDA_PREFIX}/lib/${PYTHON_VERSION}/*" \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/attr \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/direct \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/httplib2 \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/idna \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/jsonschema \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/oauth2 \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/pandac \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/pkg_resources \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/pyrsistent \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/six.py \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/ubjson \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/rpcore \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/rplibs \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/rpplugins

pip uninstall --yes \
    render-pipeline \
    attrs \
    httplib2 \
    oauth2 \
    py-ubjson
