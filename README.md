# My dotfiles

## Configurations

### Terminal and Shell
- **bash:** based on ubuntu and gentoo defaults with some minor modifications
- **zsh:** zsh configuration with zinit
- **fish:** basic fish configuration
- **starship:** cross-shell prompt configuration

### Terminal Emulators
- **ghostty:** ghostty terminal configuration
- **kitty:** kitty terminal configuration

### File Management and Utilities
- **bat:** bat config (cat replacement) with catppuccin theme
- **eza:** modern ls replacement configuration
- **yazi:** terminal file manager with catppuccin theme
- **nano:** basic nano configuration
- **vim:** vim configuration using plugged as plugin manager
- **nvim:** neovim configuration based on the kickstart project
- **tmux:** terminal multiplexer configuration with catppuccin theme
- **ssh:** secure shell configuration

### Desktop Environment
- **hypr:** hyprland, hypridle, hyprlock and hyprpaper configuration
- **waybar:** waybar configuration with catppuccin theme
- **wofi:** wofi menu configuration with catppuccin theme
- **walker:** modern application launcher (alternative to wofi)
- **wlogout:** wlogout configuration with catppuccin theme
- **swaync:** notification center with catppuccin theme

## About

These dotfiles have primarily been tested on Arch Linux. They are a collection of configurations and tweaks gathered over the years from various sources, combined with personal preferences and catppuccin theming.

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

## Dependencies

Some configurations require additional software to be installed:

### Required
- `stow`: Required for managing symlinks

### Desktop Environment
- `hyprland`: Wayland compositor
- `waybar`: Status bar
- `wofi`: Application launcher
- `walker`: Modern application launcher (optional, falls back to wofi)
- `elephant`: Required for walker
- `wlogout`: Logout menu
- `swaync`: Notification center

### Terminal Tools
- `kitty` or `ghostty`: Terminal emulator
- `bat`: Modern cat replacement
- `eza`: Modern ls replacement
- `yazi`: Terminal file manager
- `tmux`: Terminal multiplexer
- `neovim`: Text editor

### Shells
- `zsh`: Z shell
- `fish`: Friendly interactive shell
- `starship`: Cross-shell prompt

## Installation

**Warning:** This will overwrite existing dotfiles in your home directory with symlinks to the files in the `.dotfiles` directory. Use at your own risk!

The `install.sh` script will:

- Backup existing dotfiles to a timestamped directory.
- Attempt to install required dependencies using your system's package manager (if available).
- Stow all configurations.

To install:

```bash
git clone https://github.com/cskeide/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```
