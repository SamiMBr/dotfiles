#!/usr/bin/env bash

# Script to:
#           - Install zsh
#           - Install fzf zoxide and atuin
#           - Install ohmyzsh and custom plugins
#           - Copy configs
#           - Make zsh the default shell


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

packages=(zsh fzf zoxide atuin)

echo "Installing zsh and required packages"

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


echo "Installing ohmyzsh and its plugins"

# Installing oh-my-zsh

if [[ ! -e ~/.oh-my-zsh ]]; then
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Installing oh-my-zsh custom plugins

zshcustom_plugins_dir="${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom/plugins}"

# zsh completions
if [[ ! -e "$zshcustom_plugins_dir"/zsh-completions ]]; then
    git clone https://github.com/zsh-users/zsh-completions.git \
      "$zshcustom_plugins_dir"/zsh-completions
fi

# zsh syntax highlighting
if [[ ! -e "$zshcustom_plugins_dir"/zsh-syntax-highlighting ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$zshcustom_plugins_dir"/zsh-syntax-highlighting
fi

# fzf tab
if [[ ! -e "$zshcustom_plugins_dir"/fzf-tab ]]; then
    git clone https://github.com/Aloxaf/fzf-tab "$zshcustom_plugins_dir"/fzf-tab
fi

# zsh auto suggestion
if [[ ! -e "$zshcustom_plugins_dir"/zsh-autosuggestions ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$zshcustom_plugins_dir"/zsh-autosuggestions
fi

# zsh auto update custom plugins
if [[ ! -e "$zshcustom_plugins_dir"/autoupdate ]]; then
    git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins "$zshcustom_plugins_dir"/autoupdate
fi

# zsh auto pair
if [[ ! -e "$zshcustom_plugins_dir"/zsh-autopair ]]; then
    git clone https://github.com/hlissner/zsh-autopair "$zshcustom_plugins_dir"/zsh-autopair
fi

# zsh alias tips
if [[ ! -e "$zshcustom_plugins_dir"/alias-tips ]]; then
    git clone https://github.com/djui/alias-tips.git "$zshcustom_plugins_dir"/alias-tips
fi




echo "Copying zsh configuration files"

# Copy zsh configuration files

git clone https://github.com/samimbr/dotfiles /tmp/dotfiles

if [[ -e ~/.zshrc ]]; then
    mv ~/.zshrc ~/.zshrc.bak
fi
if [[ -e ~/.zshrc.d ]]; then
    mv ~/.zshrc.d ~/.zshrc.d.bak
fi

cp /tmp/dotfiles/.zshrc ~
cp -r /tmp/dotfiles/.zshrc.d ~

rm -rf /tmp/dotfiles


# Make zsh the default shell

echo "Making zsh the default shell"

chsh -s /bin/zsh

echo "Finished successfully"
