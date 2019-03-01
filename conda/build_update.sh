#!/bin/bash

VERSION=$(date +%s)

find . -name meta.yaml -exec sed -i "s/^  string\: [0-9]\+\$/  string\: ${VERSION}/g" {} \;
