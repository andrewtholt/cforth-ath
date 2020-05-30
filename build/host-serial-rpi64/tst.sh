#!/bin/bash

make  &> /dev/null

if [ $? -eq 0 ]; then
    echo "Build was a success"
else
    echo "Build failed"
    git log | head -3
fi
