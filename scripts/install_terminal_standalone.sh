#!/bin/env bash

# Common
SCRIPT_PATH=$(dirname "$(realpath -s "$0")")
ARCH=$(dpkg --print-architecture)
USER=$(whoami)

# Logs
GREEN="\033[0;32m"
NC="\033[0m"

# Update apt repositories
echo -e "${GREEN}Updating repositories...${NC}"
sudo apt update -y

# Dist upgrade
echo -e "${GREEN}Upgrading dist packages...${NC}"
sudo apt dist-upgrade -y

# Install apt packages
echo -e "${GREEN}Installing dependencies...${NC}"
sudo apt install neofetch figlet git curl zsh ranger vim -y

# Install lsd from deb package
echo -e "${GREEN}Installing lsd from deb package...${NC}"
wget -O "${HOME}"/lsd.deb https://github.com/Peltoche/lsd/releases/download/0.22.0/lsd_0.22.0_"${ARCH}".deb
sudo dpkg -i "${HOME}"/lsd.deb
rm "${HOME}"/lsd.deb

# Install bat from deb package
echo -e "${GREEN}Installing bat from deb package...${NC}"
wget -O "${HOME}"/bat.deb https://github.com/sharkdp/bat/releases/download/v0.21.0/bat_0.21.0_"${ARCH}".deb
sudo dpkg -i "${HOME}"/bat.deb
rm "${HOME}"/bat.deb

# Remove previous installation of Oh-My-Zsh if needed
echo -e "${GREEN}Installing Oh-My-Zsh...${NC}"
[ -d "${HOME}/.oh-my-zsh" ] && rm -rf "${HOME}"/.oh-my-zsh

# Install Oh-My-Zsh
curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh

# Install Oh-My-Zsh plugins
echo -e "${GREEN}Installing Oh-My-Zsh plugins...${NC}"
git clone https://github.com/zsh-users/zsh-autosuggestions.git "${HOME}"/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${HOME}"/.oh-my-zsh/custom/plugins//zsh-syntax-highlighting
git clone --quiet --depth 1 https://github.com/junegunn/fzf.git "${HOME}"/.fzf
echo -e 'y\ny\ny\n' | "${HOME}"/.fzf/install > /dev/null

# Install p10k
echo -e "${GREEN}Installing p10k...${NC}"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k

# Set zsh as default shell
echo -e "${GREEN}Setting zsh as default shell...${NC}"
sudo usermod --shell /usr/bin/zsh "${USER}"

# Hushlogin
echo -e "${GREEN}Hushing login...${NC}"
touch "${HOME}"/.hushlogin

# Copy dots
echo -e "${GREEN}Creating dots...${NC}"
cp "${SCRIPT_PATH}"/../config/.bash_aliases "${HOME}"
cp "${SCRIPT_PATH}"/../config/.p10k.zsh "${HOME}"
cp "${SCRIPT_PATH}"/../config/.zshrc "${HOME}"

# Autoremove apt packages
echo -e "${GREEN}Cleaning apt...${NC}"
sudo apt autoremove -y
