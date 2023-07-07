#!/bin/bash

VERSION=$(date +%s)

TARGETS=${1};
if [ "${1}" = "all" ]; then
    TARGETS="blender bullet panda3d panda3d-kphys panda3d-krender runtime realsense sdl";
fi
if [ "${1}" = "panda" ]; then
    TARGETS="panda3d panda3d-kphys panda3d-krender runtime";
fi
if [ "${1}" = "sdk" ]; then
    TARGETS="bullet panda3d panda3d-kphys panda3d-krender runtime";
fi

for i in ${TARGETS}; do
    echo ${i};
    find conda/${i} -name meta.yaml -exec sed -i "s/^  string\: [0-9]\+\$/  string\: ${VERSION}/g" {} \;;
done
