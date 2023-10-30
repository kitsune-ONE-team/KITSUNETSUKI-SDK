#!/bin/sh

DIR=$(dirname ${0})
TAG=docker.io/yonnji/sdk
podman build -t ${TAG} ${DIR} ${*}
podman push ${TAG}
