#!/bin/bash

set -e

AUTHORINO_VERSION=v0.23.0

mkdir -p tmp/authorino
cd tmp/authorino

curl -O -L https://github.com/Kuadrant/authorino/archive/refs/tags/${AUTHORINO_VERSION}.zip
unzip ${AUTHORINO_VERSION}.zip
cd authorino-${AUTHORINO_VERSION/v/}

# Build for ppc64le
CGO_ENABLED=0 GOOS=linux GOARCH=ppc64le GO111MODULE=on go build \
  -a \
  -ldflags "-X main.version=${AUTHORINO_VERSION} -w -s" \
  -o authorino-ppc64le \
  main.go

# Build for s390x
CGO_ENABLED=0 GOOS=linux GOARCH=s390x GO111MODULE=on go build \
  -a \
  -ldflags "-X main.version=${AUTHORINO_VERSION} -w -s" \
  -o authorino-s390x \
  main.go

echo "Binaries built:"
ls -lh authorino-ppc64le authorino-s390x
