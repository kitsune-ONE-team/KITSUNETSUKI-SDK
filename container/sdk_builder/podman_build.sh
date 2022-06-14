#!/bin/sh

TAG=docker.io/yonnji/sdk:builder
podman build -f Dockerfile -t ${TAG}
podman push ${TAG}
