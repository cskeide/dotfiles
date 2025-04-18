# Set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "/usr/local/bin" ] ; then
    export PATH="/usr/local/bin:$PATH"
fi

# Set default EDITOR/VISUAL
if command -v nvim >/dev/null 2>&1; then
    export EDITOR='nvim'
    export VISUAL='nvim'
elif command -v vim >/dev/null 2>&1; then
    export EDITOR='vim'
    export VISUAL='vim'
elif command -v vi >/dev/null 2>&1; then
    export EDITOR='vi'
    export VISUAL='vi'
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
#zinit light MichaelAquilina/zsh-you-should-use

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# Autosuggest based on both history and completion
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Keybindings
bindkey -e
bindkey '^[[3~' delete-char
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
#bindkey '^[w' kill-region

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

# Dircolors
eval "$(dircolors -b)"
alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

# Completion styling
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Include bash aliases if exists
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# Conditional alias for Kitty terminal
if [[ -n "$KITTY_WINDOW_ID" ]] && [[ -S "${XDG_RUNTIME_DIR:-/tmp}/kitty-${UID}"/* ]]; then
  alias diff="kitty +kitten diff"
  alias ssh="kitty +kitten ssh"
fi

# Oh My Posh
if (xhost >& /dev/null); then
	eval "$(oh-my-posh init zsh --config /home/cskeide/.cache/oh-my-posh/themes/catppuccin_mocha.omp.json)"
else
	PROMPT='%F{green}%n@%m %F{blue}%1~%f %# '
fi

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
