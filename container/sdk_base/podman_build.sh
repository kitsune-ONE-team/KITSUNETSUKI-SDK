#!/bin/sh

TAG=docker.io/yonnji/sdk:base
podman build -f Dockerfile -t ${TAG}
podman push ${TAG}
