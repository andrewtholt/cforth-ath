#!/bin/bash

# set -x

echo "Installing cforth ..."
BASE="/usr/local"
LIB="${BASE}/etc"
BIN="${BASE}/bin"
cp forth cforth
strip cforth
sudo mv ./cforth $BIN
sudo cp app.dic $LIB

echo "...done."

