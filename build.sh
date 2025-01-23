#!/bin/bash

if ! type -p mvn >/dev/null 2>&1; then
    echo "No maven installation detected! Terminating build..."
    exit 1
fi

git submodule update --init && ./remap.sh && ./decompile.sh && ./init.sh && ./newApplyPatches.sh && mvn clean install && ./paperclip.sh
