#!/bin/bash

# Exit on error
set -e

# Function to ask a yes/no question
ask() {
    while true; do
        read -p "$1 [y/n]: " answer
        case "$answer" in
            [Yy]* ) return 0;;  # Yes
            [Nn]* ) return 1;;  # No
            * ) echo "Please answer y or n.";;
        esac
    done
}

# Welcome message
echo "Welcome to the Neodafer setup script!"

# Step 1: Create symlinks
if ask "Do you want to create symlinks for starship.toml and .tmux.conf?"; then
    ln -sf ~/.config/nvim/starship.toml ~/.config/starship.toml
    ln -sf ~/.config/nvim/.tmux.conf ~/.tmux.conf
    echo "Symlinks created!"
else
    echo "Skipping symlink creation."
fi

# Step 2: Run full developer environment setup
if ask "Do you want to install the complete developer environment?"; then
    echo "Starting the developer environment setup..."
    
    # Initialize and populate pacman keys
    echo "Initializing and populating pacman keys..."
    sudo pacman-key --init
    sudo pacman-key --populate

    # Update system and install essential packages
    echo "Updating system and installing essential packages..."
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm base-devel git curl wget unzip zip sudo zsh neovim tmux fzf ripgrep lazygit python python-pip python-virtualenv starship

    # Set Zsh as the default shell
    echo "Setting Zsh as the default shell..."
    chsh -s "$(which zsh)"

    # Install Oh My Zsh
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || {
        echo "Oh My Zsh installation failed. Continuing...";
    }

    # Install Zsh plugins
    echo "Installing Zsh plugins..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    # Set up Python virtual environment
    echo "Setting up Python virtual environment..."
    mkdir -p ~/code/python/venvs
    python3 -m venv ~/code/python/venvs/denv

    # Install Rust
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"

    # Update .zshrc configuration
    echo "Updating .zshrc..."
    cat >> ~/.zshrc <<EOL

# Enable plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Initialize starship
eval "\$(starship init zsh)"

# Activate Python venv on startup
source ~/code/python/venvs/denv/bin/activate

# Useful aliases
alias vim='nvim'
alias lg='lazygit'

# Add cargo to path
source "\$HOME/.cargo/env"

# Automatically start Tmux on terminal open
if [[ -z "\$TMUX" ]]; then
    tmux
fi
EOL

    echo "Developer environment setup is complete! Please restart your terminal or run 'source ~/.zshrc' to apply changes."
else
    echo "Skipping developer environment setup."
fi

echo "All done!"
