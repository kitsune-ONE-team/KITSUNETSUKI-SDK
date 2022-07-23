#!/bin/sh

DIR=$(dirname ${0})
TAG=docker.io/yonnji/sdk:builder
podman build -t ${TAG} ${DIR}
podman push ${TAG}
