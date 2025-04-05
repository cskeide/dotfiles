#!/bin/bash
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DOTFILES_DIR
rm -vr ~/.bash_aliases ~/.bash_profile ~/.bashrc ~/.config/fish/config.fish ~/.vimrc ~/.nanorc ~/.tmux.conf ~/.config/hypr ~/.config/waybar ~/.config/wofi ~/.config/kitty
stow -v bash fish vim nano tmux hypr waybar wofi kitty
