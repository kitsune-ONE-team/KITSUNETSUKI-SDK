#!/bin/bash
source /etc/profile
conda activate builder

JENKINS_DIR=${HOME}/jenkins
if [ ! -d ${JENKINS_DIR} ]; then
    mkdir -p ${JENKINS_DIR};
fi

JOB_DIR=${JENKINS_DIR}/conda_root/${JOB_BASE_NAME,,}
CACHE_DIR=${JENKINS_DIR}/conda_cache

echo "CLEAN: ${CLEAN}"
if [ "${CLEAN}" = "true" ]; then
    rm -Rf ${JOB_DIR};
fi

if [ ! -d ${JOB_DIR} ]; then
    mkdir -p ${JOB_DIR};
fi

if [ ! -d ${CACHE_DIR} ]; then
    mkdir -p ${CACHE_DIR};
fi

if [ -z "${ANACONDA_TOKEN}" ]; then
    ANACONDA_TOKEN=$(cat ${HOME}/.config/binstar/https%3A%2F%2Fapi.anaconda.org.token);
else
    echo -n ${ANACONDA_TOKEN} > ${HOME}/.config/binstar/https%3A%2F%2Fapi.anaconda.org.token;
fi

CONDA_BUILD_ARGS="\
--cache-dir ${CACHE_DIR} \
--channel kitsune.one \
--croot ${JOB_DIR}/build \
--dirty \
--error-overlinking \
--keep-old-work \
--no-anaconda-upload \
--no-build-id \
--no-remove-work-dir \
--output-folder ${JOB_DIR}/output \
conda/${JOB_BASE_NAME,,}"
CONDA_PAK=$(conda build --output ${CONDA_BUILD_ARGS})

echo "CONDA BUILD: ${CONDA_PAK}"
conda build ${CONDA_BUILD_ARGS}

echo "ANACONDA UPLOAD: ${CONDA_PAK}"
anaconda \
    --disable-ssl-warnings \
    --show-traceback \
    --verbose \
    --token ${ANACONDA_TOKEN} \
    upload \
    -u kitsune.one \
    --no-progress \
    --force \
    ${CONDA_PAK}
