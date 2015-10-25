#!/bin/bash

dotfiles_dir="$(pwd)/$(dirname "$0")/dotfiles"

find "$dotfiles_dir" -type f -printf "%P\n" | while read file; do
    mkdir -p ~/"$(dirname "$file")"
    ln -s "$dotfiles_dir/$file" ~/"$file" 2>/dev/null
    if [ $? = 0 ]; then
        echo "Created symlink for $file"
    fi
done
