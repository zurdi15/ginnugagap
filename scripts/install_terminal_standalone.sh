#!/bin/env bash

SCRIPT_PATH=$(dirname $(realpath -s $0))
ARCH=$(dpkg --print-architecture)
USER=$(whoami)

# Update apt repositories
sudo apt update -y

# Install apt packages
sudo apt install neofetch figlet git curl zsh ranger vim -y

# Install lsd from deb package
wget -O ${HOME}/lsd.deb https://github.com/Peltoche/lsd/releases/download/0.22.0/lsd_0.22.0_${ARCH}.deb
sudo dpkg -i ${HOME}/lsd.deb -y
rm ${HOME}/lsd.deb

# Install bat from deb package
wget -O ${HOME}/bat.deb https://github.com/sharkdp/bat/releases/download/v0.21.0/bat_0.21.0_${ARCH}.deb
sudo dpkg -i ${HOME}/bat.deb -y
rm ${HOME}/bat.deb

# Remove previous installation of Oh-My-Zsh if needed
[ -d "${HOME}/.oh-my-zsh" ] && rm -rf ${HOME}/.oh-my-zsh

# Install Oh-My-Zsh
curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh

# Install Oh-My-Zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${HOME}/.oh-my-zsh/custom/plugins//zsh-syntax-highlighting
git clone --quiet --depth 1 https://github.com/junegunn/fzf.git ${HOME}/.fzf
echo -e 'y\ny\ny\n' | ${HOME}/.fzf/install > /dev/null

# Install p10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Set zsh as default shell
sudo usermod --shell /usr/bin/zsh ${USER}

# Hushlogin
touch ${HOME}/.hushlogin

# Copy dots
cp ${SCRIPT_PATH}/../config/.bash_aliases
cp ${SCRIPT_PATH}/../config/.p10k.zsh
cp ${SCRIPT_PATH}/../config/.zshrc

# Autoremove apt packages
sudo apt autoremove -y