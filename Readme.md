# Cloning my own config

#### Linux
```bash
git clone https://github.com/danisaski/nvim_config.git ~/.config/nvim
```

#### Windows
```powershell
git clone https://github.com/danisaski/nvim_config.git %userprofile%\AppData\Local\nvim
```

# Manual installation

## Deleting local config 

#### Linux
```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.config/nvim
```

#### Windows
```powershell
rd /s /q %userprofile%\AppData\Local\nvim
rd /s /q %userprofile%\AppData\Local\nvim-data
```

## Installing lazy.nvim

#### Linux
```bash
git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim
```

#### Windows
```powershell
git clone https://github.com/folke/lazy.nvim.git %userprofile%\AppData\Local\nvim\lazy\lazy.nvim
```

# Python Dependencies

### Install a Python language server, linter and formatter
```bash
pip install pyright ruff
```

# OS Dependencies

### Install ripgrep for telescope grep

#### Linux
```bash
sudo apt install ripgrep
```

#### Windows
```powershell
winget install BurntSushi.ripgrep.MSVC
```

# Other Dependencies

### Install Rust
#### Linux / WSL2
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### Install nodejs and npm
```bash
sudo apt update
sudo apt install nodejs npm
```

**TODO:** Debugger interface and config for RUST
ensure installed equivalent to debugpy. Reorder pluggins.lua. Autoinstall node, npm, etc.
