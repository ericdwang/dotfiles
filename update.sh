#!/bin/bash

dotfiles_dir="$(pwd)/$(dirname "$0")/dotfiles"

update() {
    curl -LSs "https://github.com/$1/raw/master/$2" -o "$dotfiles_dir/$3"
}

update seebi/dircolors-solarized dircolors.ansi-universal .dircolors
