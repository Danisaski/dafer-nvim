# Arch Linux WSL Development Environment Setup

This guide covers the installation and configuration of essential development tools on Arch Linux WSL.

## Initial System Update

First, update your system:
```bash
sudo pacman -Syu
```

## Installing Base Development Tools

Install the base development packages:
```bash
sudo pacman -S base-devel git
```

## Programming Languages and Tools

### Python
```bash
sudo pacman -S python python-pip
```

### Rust
```bash
sudo pacman -S rust
# Verify installation
rustc --version
cargo --version
```

### Node.js and npm
```bash
sudo pacman -S nodejs npm
# Verify installation
node --version
npm --version
```

## Development Tools

### Neovim
```bash
sudo pacman -S neovim
# Optional: Install vim-plug for plugin management
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

### fzf (Fuzzy Finder)
```bash
sudo pacman -S fzf
# Add to your .bashrc or .zshrc to enable fzf keybindings
source /usr/share/fzf/key-bindings.bash  # for bash
# OR
source /usr/share/fzf/key-bindings.zsh   # for zsh
```

### ripgrep
```bash
sudo pacman -S ripgrep
```

### lazygit
```bash
sudo pacman -S lazygit
```

### Starship Prompt
```bash
sudo pacman -S starship
# Add to your .bashrc or .zshrc
eval "$(starship init bash)"  # for bash
# OR
eval "$(starship init zsh)"   # for zsh
```

## Shell Configuration

Create or update your shell configuration file (~/.bashrc or ~/.zshrc):
```bash
# Add these lines to your shell configuration file

# Starship prompt
eval "$(starship init bash)"  # or zsh

# FZF configuration
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Node.js global packages without sudo
export NPM_CONFIG_PREFIX="$HOME/.npm-global"
export PATH="$HOME/.npm-global/bin:$PATH"
```

## Post-Installation Steps

1. Create NPM global directory:
```bash
mkdir ~/.npm-global
```

2. Configure Neovim (create ~/.config/nvim/init.vim):
```vim
" Basic Settings
set number
set relativenumber
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
```

3. Initialize Starship configuration (optional):
```bash
mkdir -p ~/.config
starship preset pastel-powerline > ~/.config/starship.toml
```

## Verification

Verify all installations:
```bash
python --version
rustc --version
node --version
npm --version
nvim --version
fzf --version
rg --version
lazygit --version
starship --version
```

## Troubleshooting

If you encounter permission issues with npm global packages:
```bash
npm config set prefix '~/.npm-global'
```

For Neovim plugin issues, try:
```bash
:checkhealth
```

## Notes

- Make sure to restart your shell after making changes to shell configuration files
- For WSL-specific issues, check the Windows Subsystem for Linux documentation
- Consider backing up configuration files before making changes
