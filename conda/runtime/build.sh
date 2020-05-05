#!/bin/bash

PANDA_VERSION=1.10
PYTHON_VERSION=python3.8
PYTHONVERSION=python38
RP_VERSION=1.3.3

if [ "${ARCH}" = "64" ]; then
    LARCH=x86_64;
else
    LARCH=i386;
fi

ULIBX=/usr/lib/${LARCH}-linux-gnu

pip install https://files.pythonhosted.org/packages/64/19/8b9066e94088e8d06d649e10319349bfca961e87768a525aba4a2627c986/oauth2-1.9.0.post1.tar.gz
pip install https://files.pythonhosted.org/packages/1d/c7/28220d37e041fe1df03e857fe48f768dcd30cd151480bf6f00da8713214a/py-ubjson-0.16.1.tar.gz
pip install https://files.pythonhosted.org/packages/18/9b/b95a08c373819376bf3f109bdbcff6bd4f69f2340bf708a252380319037a/httplib2-0.17.3-py3-none-any.whl
pip install https://github.com/kitsune-ONE-team/RenderPipeline/releases/download/v${RP_VERSION}/render_pipeline-${RP_VERSION}-py3-none-any.whl

mkdir -pv ${PREFIX}/kitsunetsuki-runtime/panda3d
cp -fv ${CONDA_PREFIX}/lib/lib${PYTHON_VERSION}.so.1.0   ${PREFIX}/kitsunetsuki-runtime
cp -fv ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/os.py        ${PREFIX}/kitsunetsuki-runtime

cp -Rfv ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/lib-dynload ${PREFIX}/kitsunetsuki-runtime
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_bisect.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_bz2.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_codecs_*.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_crypt.cpython-*-linux-gnu.so
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
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_testinternalcapi.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_testmultiphase.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_tkinter.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_xxtestfuzz.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/audioop.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/fcntl.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/grp.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/mmap.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/nis.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/ossaudiodev.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/parser.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/readline.cpython-*-linux-gnu.so
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
cp -fv ${RECIPE_DIR}/OpenAL-soft-LICENSE.txt      ${PREFIX}/kitsunetsuki-runtime
cp -fv ${RECIPE_DIR}/Panda3D-LICENSE.txt          ${PREFIX}/kitsunetsuki-runtime
cp -fv ${RECIPE_DIR}/jsonschema-LICENSE.txt       ${PREFIX}/kitsunetsuki-runtime
cp -fv ${RECIPE_DIR}/oauth2-LICENSE.txt           ${PREFIX}/kitsunetsuki-runtime
cp -fv ${RECIPE_DIR}/py-ubjson-LICENSE.txt        ${PREFIX}/kitsunetsuki-runtime
cp -fv ${RECIPE_DIR}/py-ubjson-NOTICE.txt         ${PREFIX}/kitsunetsuki-runtime
cp -fv ${RECIPE_DIR}/vorbis-LICENSE.txt           ${PREFIX}/kitsunetsuki-runtime
cp -fv ${RECIPE_DIR}/zlib-LICENSE.txt             ${PREFIX}/kitsunetsuki-runtime

cp -fv ${ULIBX}/libopenal.so.*                    ${PREFIX}/kitsunetsuki-runtime

cp -fv \
   ${CONDA_PREFIX}/lib/libcrypto.so.* \
   ${CONDA_PREFIX}/lib/libgcc_s.so.* \
   ${CONDA_PREFIX}/lib/libogg.so.* \
   ${CONDA_PREFIX}/lib/libp3*.so.* \
   ${CONDA_PREFIX}/lib/libp3openal_audio.so \
   ${CONDA_PREFIX}/lib/libp3ptloader.so \
   ${CONDA_PREFIX}/lib/libpanda*.so.* \
   ${CONDA_PREFIX}/lib/libpandagl.so \
   ${CONDA_PREFIX}/lib/libpng16.so.* \
   ${CONDA_PREFIX}/lib/libssl.so.* \
   ${CONDA_PREFIX}/lib/libstdc++.so.* \
   ${CONDA_PREFIX}/lib/libvorbis.so.* \
   ${CONDA_PREFIX}/lib/libvorbisfile.so.* \
   ${CONDA_PREFIX}/lib/libz.so.* \
                                                  ${PREFIX}/kitsunetsuki-runtime

7za a \
    -tzip -x@${RECIPE_DIR}/exclude.txt -xr@${RECIPE_DIR}/excluder.txt \
    ${PREFIX}/kitsunetsuki-runtime/${PYTHONVERSION}.zip \
    "${CONDA_PREFIX}/lib/${PYTHON_VERSION}/*" \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/attr \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/direct \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/httplib2 \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/httplib2-0.17.3.dist-info \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/idna \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/jsonschema \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/jsonschema-3.2.0.dist-info \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/oauth2 \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/oauth2-1.9.0.post1.dist-info \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/pandac \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/pkg_resources \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/py_ubjson-0.16.1.dist-info \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/pyrsistent \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/render_pipeline-1.3.3.dist-info \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/rpcore \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/rplibs \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/rpplugins \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/six.py \
    ${CONDA_PREFIX}/lib/${PYTHON_VERSION}/site-packages/ubjson

pip uninstall --yes \
    render-pipeline \
    httplib2 \
    oauth2 \
    py-ubjson
