KONDA=/opt/miniconda3/bin/conda
KONDA_ARGS="\
--cache-dir /var/lib/jenkins/cache \
--croot croot \
--output-folder output \
--channel kitsune.one \
conda/${JOB_BASE_NAME,,}"
KONDA_TOKEN=/home/ubuntu16/.continuum/anaconda-client/tokens/https%3A%2F%2Fapi.anaconda.org.token

${KONDA} env remove --yes --prefix env
${KONDA} create --yes --prefix env
${KONDA} install --prefix env conda-build anaconda-client

KONDA_PAK=$(env/bin/conda build --output ${KONDA_ARGS})
env/bin/conda build ${KONDA_ARGS}
env/bin/anaconda \
--verbose \
--token ${KONDA_TOKEN} \
upload \
--user kitsune.one \
--force \
${KONDA_PAK}
