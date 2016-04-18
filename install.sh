#!/bin/bash

dotfiles_dir="$(pwd)/$(dirname "$0")/dotfiles"

download() {
    if [[ ! -f $3 ]]; then
        curl -LSs "https://github.com/$1/raw/master/$2" -o "$3" --create-dirs 
        echo "Downloaded $3"
    fi
}

find "$dotfiles_dir" -type f -printf "%P\n" | while read -r file; do
    mkdir -p ~/"$(dirname "$file")"
    ln -s "$dotfiles_dir/$file" ~/"$file" 2>/dev/null
    if [[ $? == 0 ]]; then
        echo "Created symlink for $file"
    fi
done

download b4b4r07/zplug zplug ~/.zplug/zplug
download junegunn/vim-plug plug.vim ~/.vim/autoload/plug.vim
download seebi/dircolors-solarized dircolors.ansi-universal ~/.dircolors
