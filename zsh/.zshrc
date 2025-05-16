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

# Autosuggest based on both history and completion
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Add in zsh plugins
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Defer slower or non-essential plugins to improve startup time
zinit light romkatv/zsh-defer

zsh-defer zinit light zsh-users/zsh-history-substring-search
zsh-defer zinit snippet OMZL::git.zsh
zsh-defer zinit snippet OMZP::git
zsh-defer zinit snippet OMZP::sudo
zsh-defer zinit snippet OMZP::archlinux
zsh-defer zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^[[3~' delete-char
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

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

# Include bash aliases if exists
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# Conditional alias for Kitty terminal
if [[ -n "$KITTY_WINDOW_ID" ]] && [[ -S "${XDG_RUNTIME_DIR:-/tmp}/kitty-${UID}"/* ]]; then
  alias diff="kitty +kitten diff"
  alias ssh="kitty +kitten ssh"
fi

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

# Completion styling
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Oh My Posh
eval "$(oh-my-posh init zsh --config ~/.zsh/themes/onehalf.minimal.omp.json)"

# Set up fzf key bindings and fuzzy completion with catppuchin mocha theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--color=border:#313244,label:#cdd6f4"
source <(fzf --zsh)

# Zoxide shell integration
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init --cmd cd zsh)"
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && zsh-defer source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && zsh-defer \. "$NVM_DIR/bash_completion"
