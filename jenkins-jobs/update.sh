#!/bin/sh
CWD=$(pwd)
cd $(dirname ${0})
cat *.yml | ~/.venv/bin/jenkins-jobs update ${*}
cd ${CWD}
