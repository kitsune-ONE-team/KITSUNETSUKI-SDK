#!/bin/sh
CWD=$(pwd)
cd $(dirname ${0})
cat *.yml | jenkins-jobs update ${*}
cd ${CWD}
