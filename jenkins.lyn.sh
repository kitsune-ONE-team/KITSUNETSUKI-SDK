#!/bin/bash
set +x

KONDA=/opt/miniconda3/bin/conda
KONDA_ARGS="\
--cache-dir /var/lib/jenkins/cache \
--channel kitsune.one \
--croot croot \
--dirty \
--error-overlinking \
--keep-old-work \
--no-anaconda-upload \
--no-build-id \
--no-remove-work-dir \
--output-folder output \
conda/${JOB_BASE_NAME,,}"

if [ ! -d env ]; then
    ${KONDA} env remove --yes --prefix env;
    ${KONDA} create --yes --prefix env;
    ${KONDA} install --prefix env conda-build anaconda-client ripgrep;
fi

KONDA_PAK=$(env/bin/conda build --output ${KONDA_ARGS})

echo "CONDA BUILD: ${KONDA_PAK}"
env/bin/conda build ${KONDA_ARGS}

echo "ANACONDA UPLOAD: ${KONDA_PAK}"
env/bin/anaconda \
--verbose \
--token ${ANACONDA_TOKEN} \
upload \
-u kitsune.one \
--no-progress \
--force \
${KONDA_PAK}
