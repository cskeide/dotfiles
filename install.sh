#!/bin/bash
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DOTFILES_DIR
rm -vf ~/.bash_aliases ~/.bash_profile ~/.bashrc ~/.config/fish/config.fish ~/.vimrc ~/.nanorc ~/.tmux.conf
stow -v bash fish vim nano tmux
