# Cloning my own config

#### Linux
git clone https://github.com/danisaski/nvim_config.git ~/.config/nvim

#### Windows
git clone https://github.com/danisaski/nvim_config.git %userprofile%\AppData\Local\nvim


# Manual installation

# Deleting local config 

#### Linux
rm -rf ~/.local/share/nvim
rm -rf ~/.config/nvim

#### Windows
rd -r %userprofile%\AppData\Local\nvim
rd -r %userprofile%\AppData\Local\nvim-data

## Installing lazy.nvim

#### Linux
git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim

#### Windows
git clone https://github.com/folke/lazy.nvim.git %userprofile%\AppData\Local\nvim\lazy\lazy.nvim


# Python dependancies

### Install a python language server, linter and formatter

pip install pyright ruff

# OS dependancies

### Install ripgrep for telescope grep

#### Linux
sudo apt install ripgrep

#### Windows
winget install BurntSushi.ripgrep.MSVC


# Other dependancies

### Install Rust

#### WSL
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


TODO: Debugger interface and config
