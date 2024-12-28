# Development Environment Setup Guide

This guide provides setup instructions for both Arch Linux and Ubuntu/Debian WSL2 environments, focusing on a development setup with Zsh, Python, Rust, and Neovim.

## Table of Contents
- [Configuration Setup](#configuration-setup)
  - [Option A: Direct Git Repository](#option-a-direct-git-repository)
  - [Option B: Copy Method](#option-b-copy-method)
- [Arch Linux Setup](#arch-linux-setup)
- [Ubuntu/Debian Setup](#ubuntudebian-setup)
- [Common Setup Steps](#common-setup-steps)

## Configuration Setup

You have two options for managing your configuration files. Choose the one that best fits your needs:

### Option A: Direct Git Repository
This method allows you to track changes and update directly using Git.

#### For Linux (Arch/Ubuntu/Debian):
```bash
# Backup existing configurations if needed
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null
mv ~/.config/starship.toml ~/.config/starship.toml.bak 2>/dev/null

# Clone directly to the configuration directory
git clone https://github.com/Danisaski/neodafer.git ~/.config/nvim
ln -s ~/.config/nvim/starship.toml ~/.config/starship.toml

# To update configuration later:
cd ~/.config/nvim
git pull

# To clean/reset configuration:
cd ~/.config/nvim
git fetch origin
git reset --hard origin/main
```

#### For Windows (CMD):
```cmd
:: Backup existing configurations if needed
if exist "%LOCALAPPDATA%\nvim" ren "%LOCALAPPDATA%\nvim" nvim.bak
if exist "%USERPROFILE%\.config\starship.toml" ren "%USERPROFILE%\.config\starship.toml" starship.toml.bak

:: Create necessary directories
mkdir "%LOCALAPPDATA%\nvim" 2>nul
mkdir "%USERPROFILE%\.config" 2>nul

:: Clone directly to the configuration directory
cd /d "%LOCALAPPDATA%"
git clone https://github.com/Danisaski/neodafer.git nvim

:: Create symbolic link for starship config
mklink "%USERPROFILE%\.config\starship.toml" "%LOCALAPPDATA%\nvim\starship.toml"

:: To update configuration later:
cd /d "%LOCALAPPDATA%\nvim"
git pull

:: To clean/reset configuration:
cd /d "%LOCALAPPDATA%\nvim"
git fetch origin
git reset --hard origin/main
```

### Option B: Copy Method
This method creates a clean copy of the configurations without Git history.

#### For Linux (Arch/Ubuntu/Debian):
```bash
# Create necessary config directories
mkdir -p ~/.config/nvim
mkdir -p ~/.config

# Clean existing configurations
rm -rf ~/.config/nvim/*
rm -f ~/.config/starship.toml

# Clone and setup
git clone https://github.com/Danisaski/neodafer.git ~/.config/neodafer-tmp
cp -r ~/.config/neodafer-tmp/lua ~/.config/nvim/
cp ~/.config/neodafer-tmp/init.lua ~/.config/nvim/
cp ~/.config/neodafer-tmp/starship.toml ~/.config/
rm -rf ~/.config/neodafer-tmp
```

#### For Windows (CMD):
```cmd
:: Create necessary directories
mkdir "%LOCALAPPDATA%\nvim" 2>nul
mkdir "%USERPROFILE%\.config" 2>nul

:: Clean existing configurations
rd /s /q "%LOCALAPPDATA%\nvim" 2>nul
del /f "%USERPROFILE%\.config\starship.toml" 2>nul
mkdir "%LOCALAPPDATA%\nvim"

:: Clone and setup
cd /d "%TEMP%"
git clone https://github.com/Danisaski/neodafer.git neodafer-tmp
xcopy /E /I /Y neodafer-tmp\lua "%LOCALAPPDATA%\nvim\lua\"
copy /Y neodafer-tmp\init.lua "%LOCALAPPDATA%\nvim\"
copy /Y neodafer-tmp\starship.toml "%USERPROFILE%\.config\"
rd /s /q neodafer-tmp
```

### Verify Configuration

#### For Linux:
```bash
ls -la ~/.config/nvim/init.lua
ls -la ~/.config/nvim/lua
ls -la ~/.config/starship.toml
```

#### For Windows (CMD):
```cmd
dir "%LOCALAPPDATA%\nvim\init.lua"
dir "%LOCALAPPDATA%\nvim\lua"
dir "%USERPROFILE%\.config\starship.toml"
```

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
