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

env/python appx.py
