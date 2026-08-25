#!/usr/bin/env bash

# Script to:
#           - Install tmux
#           - Install tpm tmux plugin manager
#           - Install tmux plugins
#           - Copy configs

set -e

# sudo and git required
for com in sudo git; do
    if ! command -v "$com" &> /dev/null; then
        echo "$com required but not found"
        exit 1
    fi
done


# The script can run on: fedora, debian, arch, ubuntu

distro_name=$(cat /etc/os-release | grep -Po "^ID=\K.*")

packages=(tmux)

echo "Installing tmux"

case "$distro_name" in
    fedora|almalinux|rhel)
        sudo dnf install -y "${packages[@]}"
        ;;
    debian|ubuntu|kali|linuxmint|pop)
        sudo apt-get update && sudo apt-get install -y "${packages[@]}"
        ;;
    arch|sysrescue|manjaro|cachyos)
        sudo pacman -Sy && sudo pacman -S --needed --noconfirm "${packages[@]}"
        ;;
    *)
        echo "$distro_name Unsupported, you can tweak the script to make it work"
        exit 1
esac


echo "Installing tmux plugin manager"

# backup old tmux config

if [[ -e ~/.tmux.conf ]]; then
    mv ~/.tmux.conf ~/.tmux.conf.bak
fi


# creating config directory

tmux_conf_dir="$HOME/.config/tmux"

if [[ -e "$tmux_conf_dir" ]]; then
    echo "tmux configuration directory already exist, make sure to delete it, or back it up before proceding"
    exit 1
fi

mkdir -p "$tmux_conf_dir"


# Installing tmux plugin manager

if [[ ! -e "$tmux_conf_dir"/plugins/tpm ]]; then
    git clone https://github.com/tmux-plugins/tpm "$tmux_conf_dir"/plugins/tpm
fi

# Installing tmux plugins

if [[ ! -e "$tmux_conf_dir"/plugins/tmux-resurrect ]]; then
    git clone https://github.com/tmux-plugins/tmux-resurrect "$tmux_conf_dir"/plugins/tmux-resurrect
fi

if [[ ! -e "$tmux_conf_dir"/plugins/tmux-continuum ]]; then
    git clone https://github.com/tmux-plugins/tmux-continuum "$tmux_conf_dir"/plugins/tmux-continuum
fi

if [[ ! -e "$tmux_conf_dir"/plugins/tmux-prefix-highlight ]]; then
    git clone https://github.com/tmux-plugins/tmux-prefix-highlight "$tmux_conf_dir"/plugins/tmux-prefix-highlight
fi


echo "Copying tmux configuration files"

git clone https://github.com/samimbr/dotfiles /tmp/dotfiles

cp /tmp/dotfiles/.config/tmux/tmux.conf "$tmux_conf_dir"
cp -r /tmp/dotfiles/.config/tmux/tmux.conf.d "$tmux_conf_dir"

rm -rf /tmp/dotfiles

echo "Finished successfully"
