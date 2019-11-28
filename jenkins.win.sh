KONDA=/d/Apps/Miniconda3_x64/Scripts/conda
KONDA_ARGS="\
--cache-dir /d/Cache/ \
--croot croot \
--output-folder output \
--channel kitsune.one \
conda/${JOB_BASE_NAME,,}"
KONDA_TOKEN=/c/Users/WIN8/.continuum/anaconda-client/tokens/https%3A%2F%2Fapi.anaconda.org.token

${KONDA} env remove --yes --prefix env
${KONDA} create --yes --prefix env
${KONDA} install --prefix env conda-build anaconda-client

KONDA_PAK=$(env/Scripts/conda build --output ${KONDA_ARGS})
env/Scripts/conda build ${KONDA_ARGS}
env/Scripts/anaconda \
--verbose \
--token ${KONDA_TOKEN} \
upload \
--user kitsune.one \
--force \
${KONDA_PAK}
