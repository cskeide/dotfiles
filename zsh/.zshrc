# Source .zprofile if it exists and hasn't been sourced yet
if [[ -z "$ZPROFILE_SOURCED" && -f "$HOME/.zprofile" ]]; then
  source "$HOME/.zprofile"
fi

# History settings
HISTSIZE=50000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt inc_append_history
setopt hist_expire_dups_first
setopt autocd
setopt globdots
setopt auto_menu menu_complete

# Source modular Zsh config files
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"
[ -f "$HOME/.zsh/plugins.zsh" ] && source "$HOME/.zsh/plugins.zsh"
[ -f "$HOME/.zsh/keybinds.zsh" ] && source "$HOME/.zsh/keybinds.zsh"
[ -f "$HOME/.zsh/nvm.zsh" ] && source "$HOME/.zsh/nvm.zsh"

# Oh My Posh
eval "$(oh-my-posh init zsh --config ~/.zsh/themes/stelbent.omp.json)"
