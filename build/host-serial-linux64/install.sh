#!/bin/bash

# set -x

echo "Building cforth ..."
make
echo "... done."
echo "Installing cforth ..."

DICT="/usr/local/etc"
if [ -d  $DICT ]; then
    echo "... Dictionary folder exists ..."
else
    echo "... Creating dictionary"
    sudo mkdir -p $DICT
fi

echo "... Copying dictionary ..."
sudo cp app.dic $DICT
echo "... Copying executable ..."
strip forth
sudo cp forth /usr/local/bin/cforth

rm forth

echo "... done."
