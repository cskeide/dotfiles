# My dotfiles
* **bash:** based on ubuntu and gentoo defaults with some minor modifications
* **fish:** basic fish configuration
* **hypr:** hyprland configuration
* **kitty:** kitty terminal configuration
* **nano:** basic nano configuration
* **nvim:** nvim configuration with essential plugins
* **starship:** starship catppuccin theme
* **tmux:** basic tmux configuration
* **vim:** basic vim configuration
* **waybar:** waybar configuration
* **wlogout:** wlogout configuration
* **wofi:** wofi menu configuration
* **zsh:** zsh configuration with zinit and oh my posh

## About
These dotfiles have primarily been tested on Arch Linux. They are a collection of configurations and tweaks gathered over the years from various sources, combined with personal preferences.

## Using GNU Stow
This project uses GNU Stow to manage dotfiles. Stow creates symlinks from the `.dotfiles` directory to your home directory, making it easy to manage and version-control your configurations.

To stow a specific configuration (e.g., `zsh`):
```bash
stow zsh
```

To unstow a configuration:
```bash
stow -D zsh
```

You can stow all configurations at once by running the `install.sh` script.

## Installation
**Warning:** This will overwrite existing dotfiles in your home directory with symlinks to the files in the `.dotfiles` directory. Use at your own risk!

The `install.sh` script will:
- Backup existing dotfiles to a timestamped directory.
- Attempt to install required dependencies using your system's package manager (if available).
- Stow all configurations.

To install:
```bash
git clone https://github.com/your-username/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```
