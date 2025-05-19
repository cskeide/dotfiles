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

# Other variables used by zsh plugins
ZOXIDE_CMD_OVERRIDE="cd"

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
zsh-defer zinit snippet OMZP::nvm
zsh-defer zinit snippet OMZP::zoxide

# Load completions
autoload -Uz colors && colors
autoload -Uz compinit && compinit
zinit cdreplay -q