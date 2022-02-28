#!/bin/sh

podman-compose \
    -f container/sdk_base/docker-compose.yml \
    run --name sdk sdk
