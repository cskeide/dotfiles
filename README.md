# My dotfiles
* **.bash_profile:** default arch linux .bash_profile
* **.bashrc:** based on gentoo default with modifications
* **.bash_aliases:** custom aliases goes here
* **.nanorc:** nano syntax highlighting
* **.vimrc:** vim configuration

## Installation
**Warning:** This will overwrite exisiting dotfiles in your home directory with symlinks to the files in the .dotfiles directory. Use at your own risk!
```bash
cd ~
git clone https://github.com/cskeide/dotfiles.git .dotfiles/
cd .dotfiles
./install.sh
```
