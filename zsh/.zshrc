# Source .zprofile if it exists
if [[ -z "$ZPROFILE_SOURCED" && -f "$HOME/.zprofile" ]]; then
    source "$HOME/.zprofile"
fi

# Source modular Zsh config files
[ -f "$HOME/.zsh/plugins.zsh" ] && source "$HOME/.zsh/plugins.zsh"
[ -f "$HOME/.zsh/keybinds.zsh" ] && source "$HOME/.zsh/keybinds.zsh"
[ -f "$HOME/.zsh/prompt.zsh" ] && source "$HOME/.zsh/prompt.zsh"
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

# History
HISTSIZE=5000
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

# Completion styling
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
