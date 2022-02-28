#!/bin/sh

podman-compose \
    -f container/sdk_base/docker-compose.yml \
    down

podman rm sdk
