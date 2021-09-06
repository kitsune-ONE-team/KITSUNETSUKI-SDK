#!/bin/bash
PATH=${PATH}:/opt/miniconda3/bin

WORKSPACES=/var/lib/jenkins/build
if [ ! -d ${WORKSPACES} ]; then
    mkdir -p ${WORKSPACES};
fi

WORKSPACE=${WORKSPACES}/${JOB_BASE_NAME,,}

echo "CLEAN: ${CLEAN}"
if [ "${CLEAN}" = "true" ]; then
    rm -Rf ${WORKSPACE};
fi

if [ ! -d ${WORKSPACE} ]; then
    mkdir -p ${WORKSPACE};
fi

CACHE=/var/lib/jenkins/cache
if [ ! -d ${CACHE} ]; then
    mkdir -p ${CACHE};
fi

KONDA_ARGS="\
--cache-dir ${CACHE} \
--channel kitsune.one \
--croot ${WORKSPACE}/build \
--dirty \
--error-overlinking \
--keep-old-work \
--no-anaconda-upload \
--no-build-id \
--no-remove-work-dir \
--output-folder ${WORKSPACE}/output \
conda/${JOB_BASE_NAME,,}"
KONDA_PAK=$(conda build --output ${KONDA_ARGS})

echo "CONDA BUILD: ${KONDA_PAK}"
conda build ${KONDA_ARGS}

echo "ANACONDA UPLOAD: ${KONDA_PAK}"
anaconda \
    --disable-ssl-warnings \
    --show-traceback \
    --verbose \
    --token ${ANACONDA_TOKEN} \
    upload \
    -u kitsune.one \
    --no-progress \
    --force \
    ${KONDA_PAK}
