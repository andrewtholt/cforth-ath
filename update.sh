#!/bin/bash

set -x

git fetch upstream
git checkout master
git merge upstream/master
