#!/bin/bash

set -x

GIT_VERSION="$(git describe --abbrev=4 --dirty --always --tags)"

echo $GIT_VERSION | grep "dirty$"

if [ $? -eq 0 ]; then
    echo "Please commit, push and tag changes"
    exit 1
fi

echo ": version s\" $GIT_VERSION\" ;" > ../../src/app/host-serial/version.fth
echo ": .version version type cr ;" >> ../../src/app/host-serial/version.fth

