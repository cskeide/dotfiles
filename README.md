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

## Installation
**Warning:** This will overwrite exisiting dotfiles in your home directory with symlinks to the files in the .dotfiles directory. Use at your own risk!
```bash
cd ~
git clone https://github.com/cskeide/dotfiles.git .dotfiles/
cd .dotfiles
./install.sh
```
