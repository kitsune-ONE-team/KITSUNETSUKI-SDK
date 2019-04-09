#!/bin/bash

python setup.py

mkdir -p ${PREFIX}/lib/python3.7/site-packages/rpcore/native

rm -Rf rplibs/yaml/yaml_py2

cp -R config                     ${PREFIX}/lib/python3.7/site-packages/
cp -R data                       ${PREFIX}/lib/python3.7/site-packages/
cp -R effects                    ${PREFIX}/lib/python3.7/site-packages/
cp -R rplibs                     ${PREFIX}/lib/python3.7/site-packages/
cp -R rpplugins                  ${PREFIX}/lib/python3.7/site-packages/
cp -R toolkit                    ${PREFIX}/lib/python3.7/site-packages/

cp -v rpcore/*.py                ${PREFIX}/lib/python3.7/site-packages/rpcore/
cp -R rpcore/gui                 ${PREFIX}/lib/python3.7/site-packages/rpcore/
cp -R rpcore/pluginbase          ${PREFIX}/lib/python3.7/site-packages/rpcore/
cp -R rpcore/shader              ${PREFIX}/lib/python3.7/site-packages/rpcore/
cp -R rpcore/stages              ${PREFIX}/lib/python3.7/site-packages/rpcore/
cp -R rpcore/util                ${PREFIX}/lib/python3.7/site-packages/rpcore/

cp rpcore/native/__init__.py  ${PREFIX}/lib/python3.7/site-packages/rpcore/native/
cp rpcore/native/use_cxx.flag ${PREFIX}/lib/python3.7/site-packages/rpcore/native/
