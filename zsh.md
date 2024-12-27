# Arch Linux WSL Setup with ZSH and Starship

This guide will help you set up Arch Linux on WSL with ZSH, Oh My Zsh, and preserve your Starship prompt configuration.

## Prerequisites

- Windows Subsystem for Linux (WSL2) enabled
- Administrative access to Windows
- Your existing `starship.toml` configuration file

## Installing Arch Linux WSL

1. Download Arch Linux WSL from the Microsoft Store or use a custom distro:
```powershell
# Run in PowerShell as Administrator
wsl --install -d Arch
```

2. Initial system update:
```bash
sudo pacman-key --init
sudo pacman-key --populate
sudo pacman -Syu
```

## Installing Required Packages

1. Install base packages:
```bash
sudo pacman -S zsh git curl wget base-devel
```

2. Install Starship if not already installed:
```bash
sudo pacman -S starship
```

## Setting up ZSH

1. Change your default shell to ZSH:
```bash
chsh -s $(which zsh)
```

2. Install Oh My Zsh:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

3. Install ZSH plugins:
```bash
# Clone zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Clone zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

## Configuration

1. Configure ZSH plugins by editing `~/.zshrc`:
```bash
# Open .zshrc in your preferred editor
nano ~/.zshrc

# Find the plugins line and update it to:
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```

2. Set up Starship:
```bash
# Create the configuration directory if it doesn't exist
mkdir -p ~/.config

# Copy your existing starship.toml
# From Windows (PowerShell):
cp /mnt/c/Users/YourUsername/.config/starship.toml ~/.config/

# Add Starship initialization to .zshrc (if not already present)
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
```

3. Additional ZSH settings (optional but recommended):
```bash
# Add these to your .zshrc
export HIST_STAMPS="yyyy-mm-dd"
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
```

## Final Steps

1. Restart your shell:
```bash
exec zsh
```

2. Verify your setup:
- ZSH should be your default shell
- Autosuggestions should appear as you type
- Syntax highlighting should be visible
- Your Starship prompt should be working as expected

## Troubleshooting

If autosuggestions or syntax highlighting aren't working:
1. Check that the plugins are properly listed in your `.zshrc`
2. Verify that the plugin directories exist in `~/.oh-my-zsh/custom/plugins/`
3. Check plugin permissions: `ls -la ~/.oh-my-zsh/custom/plugins/`

If Starship isn't working:
1. Verify that `starship.toml` exists in `~/.config/`
2. Check that the Starship initialization line is in your `.zshrc`
3. Run `echo $SHELL` to confirm you're using ZSH

## Additional Resources

- [Oh My Zsh Documentation](https://github.com/ohmyzsh/ohmyzsh/wiki)
- [Starship Documentation](https://starship.rs/guide/)
- [ZSH Autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [ZSH Syntax Highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
