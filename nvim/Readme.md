# Installing Lazy

#### Install Lazy in Linux
git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim

#### Install Lazy in Windows
git clone https://github.com/folke/lazy.nvim.git %userprofile%\AppData\Local\nvim\lazy\lazy.nvim

# Deleting local config 

#### Linux
rm -rf ~/.local/share/nvim/lazy

#### Windows
rd -r %userprofile%\AppData\Local\nvim
rd -r %userprofile%\AppData\Local\nvim-data

# Python dependancies

### Install python language server, linter and formatter

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
