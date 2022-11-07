#!/bin/bash
if [ "${ARCH}" = "64" ]; then
    LARCH=x86_64;
else
    LARCH=i386;
fi

ULIBX=/usr/lib/${LARCH}-linux-gnu
PANDA_VERSION=1.11
PYTHON_VERSION=3.10
RP_VERSION=2.0.4

pip install git+https://github.com/Moguri/panda3d-gltf.git@v0.13
pip install git+https://github.com/Iotic-Labs/py-ubjson.git@v0.16.1
pip install git+https://github.com/httplib2/httplib2.git@v0.20.2
pip install git+https://github.com/joestump/python-oauth2.git@v1.9
pip install https://github.com/kitsune-ONE-team/RenderPipeline/releases/download/v${RP_VERSION}/render_pipeline-${RP_VERSION}-py3-none-any.whl
pip install https://files.pythonhosted.org/packages/1b/ed/0be2dc05391e2ab43a07be0b0c9e068f70eb9811ab6b1d407c9c3f245d32/nvidia_ml_py-11.515.0-py3-none-any.whl

mkdir -pv ${PREFIX}/kitsunetsuki-runtime/panda3d
mkdir -pv ${PREFIX}/kitsunetsuki-runtime/include
cp -fv ${CONDA_PREFIX}/lib/libpython${PYTHON_VERSION}.so.1.0 \
                                                            ${PREFIX}/kitsunetsuki-runtime/
cp -fv ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/os.py \
                                                            ${PREFIX}/kitsunetsuki-runtime/
cp -Rfv ${CONDA_PREFIX}/include/python${PYTHON_VERSION}/* \
                                                            ${PREFIX}/kitsunetsuki-runtime/include/

cp -Rfv ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/lib-dynload \
                                                            ${PREFIX}/kitsunetsuki-runtime
cp -Rfv ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/kphys \
                                                            ${PREFIX}/kitsunetsuki-runtime
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_bisect.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_codecs_*.cpython-*-linux-gnu.so
rm -fv ${PREFIX}/kitsunetsuki-runtime/lib-dynload/_crypt.cpython-*-linux-gnu.so
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
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/panda3d/*.so \
                                                            ${PREFIX}/kitsunetsuki-runtime/panda3d/
cp -fv \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/httplib2/cacerts.txt \
                                                            ${PREFIX}/kitsunetsuki-runtime

cp -fv ${RECIPE_DIR}/Miniconda3-LICENSE.txt                 ${PREFIX}/kitsunetsuki-runtime
cp -fv ${RECIPE_DIR}/OpenAL-soft-LICENSE.txt                ${PREFIX}/kitsunetsuki-runtime
cp -fv ${RECIPE_DIR}/Panda3D-LICENSE.txt                    ${PREFIX}/kitsunetsuki-runtime
cp -fv ${RECIPE_DIR}/jsonschema-LICENSE.txt                 ${PREFIX}/kitsunetsuki-runtime
cp -fv ${RECIPE_DIR}/oauth2-LICENSE.txt                     ${PREFIX}/kitsunetsuki-runtime
cp -fv ${RECIPE_DIR}/py-ubjson-LICENSE.txt                  ${PREFIX}/kitsunetsuki-runtime
cp -fv ${RECIPE_DIR}/py-ubjson-NOTICE.txt                   ${PREFIX}/kitsunetsuki-runtime
cp -fv ${RECIPE_DIR}/vorbis-LICENSE.txt                     ${PREFIX}/kitsunetsuki-runtime
cp -fv ${RECIPE_DIR}/zlib-LICENSE.txt                       ${PREFIX}/kitsunetsuki-runtime

cp -fv ${ULIBX}/libopenal.so.*                              ${PREFIX}/kitsunetsuki-runtime
cp -fv ${ULIBX}/libsndio.so.*                               ${PREFIX}/kitsunetsuki-runtime

cp -fv \
   ${CONDA_PREFIX}/lib/libcrypto.so.* \
   ${CONDA_PREFIX}/lib/libffi.so.* \
   ${CONDA_PREFIX}/lib/libfreetype.so.* \
   ${CONDA_PREFIX}/lib/libglib-2.0.so.* \
   ${CONDA_PREFIX}/lib/libgraphite2.so.* \
   ${CONDA_PREFIX}/lib/libharfbuzz.so.* \
   ${CONDA_PREFIX}/lib/libogg.so.* \
   ${CONDA_PREFIX}/lib/libp3*.so.* \
   ${CONDA_PREFIX}/lib/libp3openal_audio.so \
   ${CONDA_PREFIX}/lib/libp3ptloader.so \
   ${CONDA_PREFIX}/lib/libpanda*.so.* \
   ${CONDA_PREFIX}/lib/libpandagl.so \
   ${CONDA_PREFIX}/lib/libpcre.so.* \
   ${CONDA_PREFIX}/lib/libpng16.so.* \
   ${CONDA_PREFIX}/lib/libssl.so.* \
   ${CONDA_PREFIX}/lib/libvorbis.so.* \
   ${CONDA_PREFIX}/lib/libvorbisfile.so.* \
                                                            ${PREFIX}/kitsunetsuki-runtime

cp -fv \
   ${CONDA_PREFIX}/lib/libpandaegg.so.${PANDA_VERSION} \
                                                            ${PREFIX}/kitsunetsuki-runtime/libpandaegg.so

7za a \
    -tzip -x@${RECIPE_DIR}/exclude.txt -xr@${RECIPE_DIR}/excluder.txt \
    ${PREFIX}/kitsunetsuki-runtime/python${PYTHON_VERSION/./}.zip \
    "${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/*" \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/attr \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/config \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/direct \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/effects \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/gltf \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/httplib2 \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/httplib2-0.20.2.dist-info \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/idna \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/jsonschema \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/jsonschema-3.2.0.dist-info \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/oauth2 \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/oauth2-1.9.0.dist-info \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/panda3d.dist-info \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/panda3d_gltf-0.13.dist-info \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/pandac \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/pkg_resources \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/py_ubjson-0.16.1.dist-info \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/pynvml.py \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/pyparsing \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/pyrsistent \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/render_pipeline-${RP_VERSION}.dist-info \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/rpcore \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/rplibs \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/rpplugins \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/shader \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/six.py \
    ${CONDA_PREFIX}/lib/python${PYTHON_VERSION}/site-packages/ubjson

pip uninstall --yes \
    httplib2 \
    oauth2 \
    panda3d-gltf \
    py-ubjson \
    render-pipeline \
    nvidia-ml-py
