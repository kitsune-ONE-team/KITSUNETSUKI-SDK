#!/bin/bash
source /etc/profile
conda activate builder
# PATH=${PATH}:/opt/miniconda3/bin

JENKINS_DIR=${HOME}/jenkins/conda
if [ ! -d ${JENKINS_DIR} ]; then
    mkdir -p ${JENKINS_DIR};
fi

JOB_DIR=${JENKINS_DIR}/${JOB_BASE_NAME,,}
CACHE_DIR=${JENKINS_DIR}/cache

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
