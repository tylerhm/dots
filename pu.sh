#!/bin/bash

home=$(echo "$HOME")

script=$(realpath "$0")
dotsdir=$(dirname "$script")

# Iterate over all files that aren't .git/* or this script
find . | grep -Ev "^(\.|.*(\.git|pu\.sh|LICENSE|README.md).*)$" | while read -r file; do
    if [[ ! -d $file ]]; then
        parentdir=$(dirname "$file")
        destdir="${home}/${parentdir}"

        if [[ ! -d $destdir ]]; then
            echo "Initializing ${destdir}"
            mkdir -p "$destdir"
        fi

        absfrom="${dotsdir}/${file}"
        linktarg="${home}/${file}"

        filename=$(basename "$file")
        echo "Linking ${filename}"

        ln -sf "$absfrom" "$linktarg"
    fi
done
