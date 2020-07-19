#!/bin/bash

GITHUB_URL="https://github.com"

dotfiles_dir="$(pwd)/$(dirname "$0")/dotfiles"

find "$dotfiles_dir" -type f -printf "%P\n" | while read -r file; do
    mkdir -p ~/"$(dirname "$file")"
    ln -s "$dotfiles_dir/$file" ~/"$file" 2>/dev/null
    if [[ $? == 0 ]]; then
        echo "Created symlink for $file"
    fi
done

download() {
    if [[ $# == 2 ]]; then
        if [[ ! -d $2 ]]; then
            git clone -q "$GITHUB_URL/$1" "$2"
            echo "Downloaded $2"
        fi
    else
        if [[ ! -f $3 ]]; then
            curl -LSs "$GITHUB_URL/$1/raw/master/$2" -o "$3" --create-dirs
            echo "Downloaded $3"
        fi
    fi
}

download dexpota/kitty-themes themes/Argonaut.conf ~/.config/kitty/theme.conf
download junegunn/vim-plug plug.vim ~/.vim/autoload/plug.vim
download seebi/dircolors-solarized dircolors.ansi-universal ~/.dircolors
download tarjoilija/zgen ~/.zgen
