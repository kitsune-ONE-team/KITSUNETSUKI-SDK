#!/bin/sh

TAG=docker.io/yonnji/sdk:main
podman build -f Dockerfile -t ${TAG}
podman push ${TAG}
