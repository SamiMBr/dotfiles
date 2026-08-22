#!/usr/bin/env bash

# Script to:
#           - Install kitty
#           - Copy configs

set -e

# git required
if ! command -v git &> /dev/null; then
    echo "git required but not found"
    exit 1
fi


# The script can run on: fedora, debian, arch, ubuntu

distro_name=$(cat /etc/os-release | grep -Po "^ID=\K.*")

packages=(kitty kitty-shell-integration kitty-terminfo)

echo "Installing kitty"

case "$distro_name" in
    fedora)
        sudo dnf install -y "${packages[@]}"
        ;;
    debian)
        sudo apt-get update && sudo apt-get install -y "${packages[@]}"
        ;;
    ubuntu)
        sudo apt-get update && sudo apt-get install -y "${packages[@]}"
        ;;
    arch)
        sudo pacman -Sy && sudo pacman -S --needed "${packages[@]}"
        ;;
    *)
        echo "$distro_name Unsupported, you can tweak the script to make it work"
        exit 1
esac

echo "Installing firacode font"

debpackage=(fonts-firacode)
dnfpackage=(firacode-nerd-fonts)
archpackage=(ttf-firacode-nerd)

case "$distro_name" in
    fedora)
        sudo dnf install -y "${dnfpackage[@]}"
        ;;
    debian|ubuntu)
        sudo apt-get update && sudo apt-get install -y "${debpackage[@]}"
        ;;
    arch)
        sudo pacman -Sy && sudo pacman -S --needed "${archpackage[@]}"
        ;;
    *)
        echo "$distro_name Unsupported, you can tweak the script to make it work"
        exit 1
esac


# creating config directory

kitty_conf_dir="$HOME/.config/kitty"

if [[ -e "$kitty_conf_dir" ]]; then
    echo "kitty configuration directory already exist, make sure to delete it, or back it up before proceding"
    exit 1
fi

mkdir -p "$kitty_conf_dir"


echo "Copying kitty configuration files"

git clone https://github.com/samimbr/dotfiles /tmp/dotfiles

cp -r /tmp/dotfiles/.config/kitty/* "$kitty_conf_dir"
rm -rf /tmp/dotfiles

echo "Finished successfully"
