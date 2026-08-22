#!/usr/bin/env bash

# Script to:
#           - Install vim
#           - Copy configs
#           - Install Plug plugin manager and some plugins


set -e

# curl and git required
for com in curl git; do
    if ! command -v "$com" &> /dev/null; then
        echo "$com required but not found"
        exit 1
    fi
done


# The script can run on: fedora, debian, arch, ubuntu

distro_name=$(cat /etc/os-release | grep -Po "^ID=\K.*")

# All required packages exist in main repo of distro, except for atuin on ubuntu

packages=(vim fzf)

echo "Installing Vim and required packages"

case "$distro_name" in
    fedora)
        sudo dnf install -y "${packages[@]}"
        ;;
    debian|ubuntu)
        sudo apt-get update && sudo apt-get install -y "${packages[@]}"
        ;;
    arch)
        sudo pacman -Sy && sudo pacman -S --needed "${packages[@]}"
        ;;
    *)
        echo "$distro_name Unsupported, you can tweak the script to make it work"
        exit 1
esac


echo "Copying configurations"

vim_config_dir="$HOME/.vim"

if [[ -e $vim_config_dir ]]; then
    echo "Configuration directory $vim_config_dir already exist, exiting"
    exit 1
else
    mkdir "$vim_config_dir"
fi

if [[ -e "$HOME/.vimrc" ]]; then
    mv "$HOME/.vimrc" "$HOME/.vimrc.bak"
fi

git clone https://github.com/samimbr/dotfiles /tmp/dotfiles

cp /tmp/dotfiles/.vim/vimrc "$vim_config_dir"
cp -r /tmp/dotfiles/.vim/vimrc.d "$vim_config_dir"

rm -rf /tmp/dotfiles

echo "Installing Plug plugin manager"


if [[ ! -e ~/.vim/autoload/plug.vim ]]; then
    bash -c "$(curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)"
fi

echo "To install extensions, Run: vim +PlugInstall"
echo "Finished successfully"
