#!/bin/bash

set -x

GIT_VERSION="$(git describe --abbrev=4 --dirty --always --tags)"

echo ": version s\" $GIT_VERSION\" ;" > ../../src/version.fth

