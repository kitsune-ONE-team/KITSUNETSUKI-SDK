#!/bin/sh

TAG=docker.io/yonnji/sdk:base
cd container/sdk_base
podman build -f Dockerfile -t ${TAG}
podman push ${TAG}
cd ../..

TAG=docker.io/yonnji/sdk:builder
cd container/sdk_builder
podman build -f Dockerfile -t ${TAG}
podman push ${TAG}
cd ../..

TAG=docker.io/yonnji/sdk:full
cd container/sdk_full
podman build -f Dockerfile -t ${TAG}
podman push ${TAG}
cd ../..
