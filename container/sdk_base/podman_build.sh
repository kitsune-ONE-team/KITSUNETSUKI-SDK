#!/bin/sh

DIR=$(dirname ${0})
TAG=docker.io/yonnji/sdk:base
podman build -t ${TAG} ${DIR}
podman push ${TAG}
