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

[Rest of the previous sections remain the same, starting from "Arch Linux Setup"...]