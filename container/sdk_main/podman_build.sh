#!/bin/sh

DIR=$(dirname ${0})
TAG=docker.io/yonnji/sdk:main
podman build -t ${TAG} ${DIR}
podman push ${TAG}
