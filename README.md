# My dotfiles
* **.bash_profile:** based on ubuntu default
* **.bashrc:** based on gentoo default with some minor modifications
* **.bash_aliases:** a few aliases
* **config.fish:** basic fish configuration
* **.nanorc:** basic nano configuration
* **.tmux.conf:** basic tmux configuration
* **.vimrc:** basic vim configuration

## Installation
**Warning:** This will overwrite exisiting dotfiles in your home directory with symlinks to the files in the .dotfiles directory. Use at your own risk!
```bash
cd ~
git clone https://github.com/cskeide/dotfiles.git .dotfiles/
cd .dotfiles
./install.sh
```
