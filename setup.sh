#!/bin/bash

# Color definitions
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Exit on error
set -e

# Function to print colorful messages
print_message() {
    echo -e "${BLUE}[SETUP]${NC} $1"
}

# Function to print success messages
print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Function to print error messages
print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to ask a yes/no question with default to yes
ask() {
    while true; do
        read -p "$1 [Y/n]: " answer
        # Default to yes if just Enter is pressed
        answer=${answer:-y}
        case "$answer" in
            [Yy]* ) return 0;;  # Yes
            [Nn]* ) return 1;;  # No
            * ) echo "Please answer y or n.";;
        esac
    done
}

# Welcome message
echo -e "${YELLOW}===========================================${NC}"
echo -e "${GREEN}Welcome to the Neodafer Setup Script!${NC}"
echo -e "${YELLOW}===========================================${NC}"

# Separator function
separator() {
    echo -e "${BLUE}------------------------------------------${NC}"
}

# Step 1: Create symlinks
separator
print_message "Symlink Configuration"
if ask "Create symlinks for starship.toml and .tmux.conf? (needed)"; then
    ln -sf ~/.config/nvim/starship.toml ~/.config/starship.toml
    ln -sf ~/.config/nvim/.tmux.conf ~/.tmux.conf
    print_success "Symlinks created successfully!"
else
    print_message "Skipping symlink creation."
fi

# Step 2: Run full developer environment setup
separator
print_message "Developer Environment Setup"
if ask "Install the complete developer environment?"; then
    print_message "Starting developer environment setup..."
    
    # Separator and system update
    separator
    print_message "Updating System"
    # Initialize and populate pacman keys
    print_message "Initializing and populating pacman keys..."
    sudo pacman-key --init
    sudo pacman-key --populate
    sudo pacman -Sy archlinux-keyring
    
    # Update system and install essential packages
    print_message "Updating system and installing essential packages..."
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm base-devel git curl wget unzip zip sudo zsh neovim tmux fzf ripgrep lazygit starship openssh

    # Language and Environment Installations
    separator
    print_message "Language and Environment Installations"

    # Python Setup
    if ask "Install Python and setup virtual environment?"; then
        print_message "Installing python..."
        sudo pacman -S --noconfirm python python-pip python-virtualenv
        print_message "Setting up Python virtual environment..."
        mkdir -p ~/code/python/venvs
        python3 -m venv ~/code/python/venvs/denv
        print_success "Python virtual environment created!"
    fi

    # Rust Setup
    if ask "Install Rust programming language?"; then
        print_message "Installing Rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
        print_success "Rust installed successfully!"
    fi

    # Zig Setup
    if ask "Install Zig programming language?"; then
        print_message "Installing Zig..."
        # Assuming latest version, adjust URL as needed
        sudo pacman -S --noconfirm zig
        print_success "Zig installed successfully!"
    fi

    # Node.js and npm Setup
    if ask "Install Node.js and npm? (recommended for dependancies)"; then
        print_message "Installing Node.js and npm..."
        # Using Node Version Manager (nvm) for flexible Node.js installation
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        nvm install node # installs latest Node.js
        print_success "Node.js and npm installed successfully!"
    fi

    # Shell and Configuration Setup
    separator
    print_message "Shell Configuration"

    # Set Zsh as the default shell
    print_message "Setting Zsh as the default shell..."
    chsh -s /usr/bin/zsh

    # Install Oh My Zsh
    print_message "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || {
        print_error "Oh My Zsh installation failed. Continuing...";
    }

    # Install Zsh plugins
    print_message "Installing Zsh plugins..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    # Update .zshrc configuration
    print_message "Updating .zshrc..."
    cat >> ~/.zshrc <<EOL
# Enable plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Initialize starship
eval "\$(starship init zsh)"

# Activate Python venv on startup
source ~/code/python/venvs/denv/bin/activate

# Add cargo to path
source "\$HOME/.cargo/env"

# Add NVM to path
export NVM_DIR="\$HOME/.nvm"
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"

# Automatically start Tmux on terminal open
if [[ -z "\$TMUX" ]]; then
    tmux
fi
EOL

    # Source configuration files
    separator
    print_message "Sourcing configuration files"
    source ~/.zshrc
    tmux source-file ~/.tmux.conf

    print_success "Developer environment setup is complete!"
else
    print_message "Skipping developer environment setup."
fi

# Final message
separator
echo -e "${GREEN}Setup Script Completed Successfully!${NC}"
echo -e "${YELLOW}Please restart your terminal or run 'source ~/.zshrc' to apply all changes.${NC}"
