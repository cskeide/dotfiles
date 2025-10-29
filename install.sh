#!/bin/bash
export DOTFILES_DIR
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "$DOTFILES_DIR" || exit

# Detect package manager
if command -v pacman &>/dev/null; then
  package_manager="pacman"
elif command -v apt-get &>/dev/null; then
  package_manager="apt-get"
elif command -v apt &>/dev/null; then
  package_manager="apt"
else
  echo "No supported package manager found. Dependencies will not be installed."
  package_manager=""
fi

# Install dependencies
required_packages=(stow)
echo "Installing required packages: ${required_packages[*]}"
for package in "${required_packages[@]}"; do
  if ! command -v "$package" &>/dev/null; then
    echo "Installing $package..."
    if [ "$package_manager" = "pacman" ]; then
      sudo pacman -S --noconfirm "$package" || echo "Failed to install $package. Please install it manually."
    elif [ "$package_manager" = "apt-get" ] || [ "$package_manager" = "apt" ]; then
      sudo "$package_manager" install -y "$package" || echo "Failed to install $package. Please install it manually."
    else
      echo "Failed to install $package. No supported package manager found."
    fi
  else
    echo "$package is already installed."
  fi
done

# Backup existing dotfiles before removing them
backup_dir="$HOME/dotfiles_backup_$(date +%Y%m%d%H%M%S)"
echo "Backing up existing dotfiles to $backup_dir"
mkdir -p "$backup_dir"

for file in ~/.bash_aliases ~/.bash_profile ~/.bashrc ~/.config/fish ~/.vimrc ~/.nanorc ~/.tmux.conf ~/.config/hypr ~/.config/waybar ~/.config/wofi ~/.config/kitty ~/.config/wlogout ~/.zshrc ~/.config/nvim ~/.config/ghostty ~/.config/yazi ~/.config/bat ~/.config/swaync ~/.config/eza ~/.config/starship ~/.config/walker ~/.ssh; do
  if [ -e "$file" ]; then
    mv -v "$file" "$backup_dir/"
  fi
done

stow -v bash bat eza fish vim nano tmux hypr waybar wofi kitty wlogout zsh nvim ghostty yazi swaync starship walker ssh
