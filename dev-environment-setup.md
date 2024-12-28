# Development Environment Setup Guide

This guide provides setup instructions for both Arch Linux and Ubuntu/Debian WSL2 environments, focusing on a development setup with Zsh, Python, Rust, and Neovim.

## Table of Contents
- [Arch Linux Setup](#arch-linux-setup)
- [Ubuntu/Debian Setup](#ubuntudebian-setup)
- [Common Setup Steps](#common-setup-steps)
  - [Zsh & Oh My Zsh](#zsh--oh-my-zsh)
  - [Starship Prompt](#starship-prompt)
  - [Development Tools](#development-tools)
  - [Python Setup](#python-setup)
  - [Rust Setup](#rust-setup)
  - [Neovim Setup](#neovim-setup)
  - [Zsh Configuration](#zsh-configuration)

## Arch Linux Setup

First update the system and install essential packages:
```bash
pacman-key --init
pacman-key --populate
pacman -Syu
pacman -S base-devel git curl wget unzip zip sudo

# Create your user if not exists
useradd -m -G wheel -s /bin/bash yourusername
passwd yourusername

# Enable sudo for wheel group (uncomment %wheel ALL=(ALL:ALL) ALL)
EDITOR=vim visudo
```

## Ubuntu/Debian Setup

Update the system and install essential packages:
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential git curl wget unzip zip pkg-config
```

## Common Setup Steps

### Zsh & Oh My Zsh

Install and configure Zsh:
```bash
# Arch
sudo pacman -S zsh

# Ubuntu/Debian
sudo apt install -y zsh

# Set Zsh as default shell
chsh -s $(which zsh)

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### Starship Prompt

Install Starship:
```bash
# Arch
sudo pacman -S starship

# Ubuntu/Debian
curl -sS https://starship.rs/install.sh | sh
```

### Development Tools

Install FZF, Ripgrep, and Lazygit:
```bash
# Arch
sudo pacman -S fzf ripgrep
sudo pacman -S lazygit

# Ubuntu/Debian
sudo apt install -y fzf ripgrep
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
```

### Python Setup

Install Python and virtualenv:
```bash
# Arch
sudo pacman -S python python-pip python-virtualenv

# Ubuntu/Debian
sudo apt install -y python3 python3-pip python3-venv

# Create default virtual environment directory
mkdir -p ~/code/python/venvs
python3 -m venv ~/code/python/venvs/denv
```

### Rust Setup

Install Rust using rustup:
```bash
# Both distributions
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
```

### Neovim Setup

Install Neovim:
```bash
# Arch
sudo pacman -S neovim

# Ubuntu/Debian
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
```

### Zsh Configuration

Add these lines to your `~/.zshrc`:
```bash
# Enable plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Initialize starship
eval "$(starship init zsh)"

# Activate Python venv on startup
source ~/code/python/venvs/denv/bin/activate

# Useful aliases
alias vim='nvim'
alias lg='lazygit'

# Add cargo to path
source "$HOME/.cargo/env"
```

## Post-Installation

1. Restart your shell:
```bash
exec zsh
```

2. Verify installations:
```bash
nvim --version
python3 --version
rustc --version
starship --version
```

Remember to:
- Clone your personal Starship configuration
- Clone your Neovim configuration
- Configure any additional Git settings

## Dependencies Overview

The setup includes these main dependencies:
- Base development tools (gcc, make, etc.)
- Git for version control
- Curl for downloads
- Pkg-config for compilation
- Zsh shell dependencies
- Python build dependencies
- Neovim dependencies

Note: Some commands might require re-logging or restarting your terminal to take effect.