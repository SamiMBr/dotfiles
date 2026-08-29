#!/usr/bin/env bash

# Script to:
#           - Install kitty
#           - Copy configs

set -e

# sudo and git required
for com in sudo  git; do
    if ! command -v "$com" &> /dev/null; then
        echo "$com required but not found"
        exit 1
    fi
done


# The script can run on: fedora, debian, arch, ubuntu

distro_name=$(cat /etc/os-release | grep -Po "^ID=\K.*")

packages=(kitty kitty-shell-integration kitty-terminfo)

# installing firecode font, different package names for different distros
debpackage=(fonts-firacode)
dnfpackage=(firacode-nerd-fonts)
archpackage=(ttf-firacode-nerd)


echo "Installing kitty"

case "$distro_name" in
    fedora|almalinux|rhel)
        sudo dnf install -y "${packages[@]}" "${dnfpackage[@]}"
        ;;
    debian|ubuntu|kali|linuxmint|pop)
        sudo apt-get update && sudo apt-get install -y "${packages[@]}" "${debpackage[@]}"
        ;;
    arch|sysrescue|manjaro|cachyos)
        sudo pacman -Sy && sudo pacman -S --needed --noconfirm "${packages[@]}" "${archpackage[@]}"
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
