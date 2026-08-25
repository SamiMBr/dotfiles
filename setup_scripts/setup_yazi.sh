#!/usr/bin/env bash

# Script to:
#           - Install yazi
#           - Install yazi plugins
#           - Copy configs

set -e

# sudo, curl and git required
for com in sudo curl git; do
    if ! command -v "$com" &> /dev/null; then
        echo "$com required but not found"
        exit 1
    fi
done


# The script can run on: fedora, debian, arch, ubuntu

distro_name=$(cat /etc/os-release | grep -Po "^ID=\K.*")

packages=(yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick)

echo "Installing tmux"

case "$distro_name" in
    fedora|almalinux|rhel)
        sudo dnf copr enable -y lihaohong/yazi
        sudo dnf install -y yazi
        ;;
    debian|ubuntu|kali|linuxmint|pop)
        curl -fsSL https://yazi-rs.github.io/builds/yazi-keyring.gpg | sudo tee /usr/share/keyrings/yazi-keyring.gpg >/dev/null
        echo 'deb [signed-by=/usr/share/keyrings/yazi-keyring.gpg] https://yazi-rs.github.io/builds/ stable main' | sudo tee /etc/apt/sources.list.d/yazi.list >/dev/null
        sudo apt-get update && sudo apt-get install -y yazi
        ;;
    arch|sysrescue|manjaro|cachyos)
        sudo pacman -Sy && sudo pacman -S --needed --noconfirm "${packages[@]}"
        ;;
    *)
        echo "$distro_name Unsupported, you can tweak the script to make it work"
        exit 1
esac




echo "Copying configuration"

# backup old yazi config

if [[ -e ~/.config/yazi ]]; then
    mv ~/.config/yazi ~/.config/yazi_bak
fi

# copy configs
git clone https://github.com/samimbr/dotfiles /tmp/dotfiles

cp -r /tmp/dotfiles/.config/yazi ~/.config/yazi

rm ~/.config/yazi/package.toml
rm -rf /tmp/dotfiles

echo "Installing yazi plugins"

ya pkg add yazi-rs/plugins:piper
ya pkg add boydaihungst/mediainfo
ya pkg add AminurAlam/yazi-plugins:preview-audio

echo "Finished successfully"
