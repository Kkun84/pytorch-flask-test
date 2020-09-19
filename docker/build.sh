#!/bin/bash
docker build \
    --pull \
    --rm \
    -f "Dockerfile" \
    --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg USER=$(basename $PWD) --build-arg PASSWORD=$(basename $PWD) \
    -t \
    pytorch_flask_test:latest "."
