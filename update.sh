#!/bin/bash

set -x

git fetch upstream
git checkout WIP
git merge upstream/WIP
