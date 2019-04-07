#!/bin/bash

mkdir -pv ${PREFIX}/python/lib/python3.7/site-packages;

cp -Rfv ${CONDA_PREFIX}/lib/python3.7/site-packages/rpcore \
   ${PREFIX}/python/lib/python3.7/site-packages/;
cp -Rfv ${CONDA_PREFIX}/lib/python3.7/site-packages/rplibs \
   ${PREFIX}/python/lib/python3.7/site-packages/;
cp -Rfv ${CONDA_PREFIX}/lib/python3.7/site-packages/rpplugins \
   ${PREFIX}/python/lib/python3.7/site-packages/;
cp -Rfv ${CONDA_PREFIX}/lib/python3.7/site-packages/data \
   ${PREFIX}/python/lib/python3.7/site-packages/;
cp -Rfv ${CONDA_PREFIX}/lib/python3.7/site-packages/effects \
   ${PREFIX}/python/lib/python3.7/site-packages/;

rm -f ${PREFIX}/python/lib/python3.7/site-packages/data/builtin_models/skybox/skybox-blend.zip;
rm -f ${PREFIX}/python/lib/python3.7/site-packages/data/builtin_models/skybox/skybox.jpg;
rm -f ${PREFIX}/python/lib/python3.7/site-packages/data/builtin_models/skybox/skybox-2.jpg;
rm -Rf ${PREFIX}/python/lib/python3.7/site-packages/data/default_cubemap;
rm -f ${PREFIX}/python/lib/python3.7/site-packages/data/generate_txo_files.py;
rm -f ${PREFIX}/python/lib/python3.7/site-packages/data/environment_brdf/generate_reference.py;
rm -f ${PREFIX}/python/lib/python3.7/site-packages/data/environment_brdf/run_mitsuba.bat;
rm -Rf ${PREFIX}/python/lib/python3.7/site-packages/data/environment_brdf/res;
rm -f ${PREFIX}/python/lib/python3.7/site-packages/data/film_grain/generate.py;
rm -f ${PREFIX}/python/lib/python3.7/site-packages/data/film_grain/grain.compute.glsl;
rm -f ${PREFIX}/python/lib/python3.7/site-packages/data/ies_profiles/PREVIEWS.jpg;
rm -f ${PREFIX}/python/lib/python3.7/site-packages/data/gui/loading_screen_bg.png;

rm -f ${PREFIX}/python/lib/python3.7/site-packages/rpplugins/bloom/resources/SOURCE.txt;
rm -f ${PREFIX}/python/lib/python3.7/site-packages/rpplugins/bloom/resources/lens_dirt.png;
rm -f ${PREFIX}/python/lib/python3.7/site-packages/rpplugins/clouds/resources/generate_noise1.compute.glsl;
rm -f ${PREFIX}/python/lib/python3.7/site-packages/rpplugins/clouds/resources/generate_noise2.compute.glsl;
rm -f ${PREFIX}/python/lib/python3.7/site-packages/rpplugins/clouds/resources/noise.inc;
rm -f ${PREFIX}/python/lib/python3.7/site-packages/rpplugins/clouds/resources/precompute.py;
rm -f ${PREFIX}/python/lib/python3.7/site-packages/rpplugins/color_correction/resources/film_luts/agfa_*;
rm -f ${PREFIX}/python/lib/python3.7/site-packages/rpplugins/color_correction/resources/film_luts/fujifilm_*;
rm -f ${PREFIX}/python/lib/python3.7/site-packages/rpplugins/color_correction/resources/film_luts/kodak_*;
rm -Rf ${PREFIX}/python/lib/python3.7/site-packages/rpplugins/color_correction/resources/film_luts_raw;
rm -f ${PREFIX}/python/lib/python3.7/site-packages/rpplugins/color_correction/resources/generate_default_lut.py;
rm -f ${PREFIX}/python/lib/python3.7/site-packages/rpplugins/color_correction/resources/generate_film_luts.py;
rm -Rf ${PREFIX}/python/lib/python3.7/site-packages/rpplugins/plugin_prefab;
rm -Rf ${PREFIX}/python/lib/python3.7/site-packages/rpplugins/scattering/resources/hosek_wilkie_scattering;
