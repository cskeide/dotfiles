#!/bin/bash
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DOTFILES_DIR
rm -vf ~/.bashrc ~/.bash_profile ~/.bash_aliases ~/.config/fish/config.fish ~/.vimrc ~/.nanorc
stow -v bash fish nano vim
