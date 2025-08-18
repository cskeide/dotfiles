# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Better history handling
HISTCONTROL=ignoreboth
HISTSIZE=50000
HISTFILESIZE=200000
shopt -s histappend     # append instead of overwrite
shopt -s cmdhist        # multi-line commands as one entry
shopt -s checkwinsize
shopt -s no_empty_cmd_completion

# Share history across terminals
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Set colorful PS1 only on colorful terminals.
use_color=false
if type -P dircolors >/dev/null; then
  # Enable colors for ls, etc.  Prefer ~/.dir_colors
  LS_COLORS=
  if [[ -f ~/.dir_colors ]]; then
    eval "$(dircolors -b ~/.dir_colors)"
  elif [[ -f /etc/DIR_COLORS ]]; then
    eval "$(dircolors -b /etc/DIR_COLORS)"
  else
    eval "$(dircolors -b)"
  fi
  
  if [[ -n ${LS_COLORS:+set} ]]; then
    use_color=true
  else
    unset LS_COLORS
  fi
else
  # Some systems (e.g. BSD & embedded) don't typically come with
  # dircolors so we need to hardcode some terminals in here.
  case ${TERM} in
  [aEkx]term* | rxvt* | gnome* | konsole* | screen | cons25 | *color) use_color=true ;;
  esac
fi

if ${use_color}; then
  if [[ ${EUID} == 0 ]]; then
    PS1='\[\033[01;31m\]\h\[\033[01;34m\] \w\[\033[00m\]'
  else
    PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[00m\]'
  fi

  alias ls='ls --color=auto'
  alias grep='grep --colour=auto'
  alias egrep='egrep --colour=auto'
  alias fgrep='fgrep --colour=auto'
else
  # show root@ when we don't have colors
  PS1+='\u@\h \w \$ '
fi

if [ -f /usr/share/git/git-prompt.sh ]; then
    source /usr/share/git/git-prompt.sh
    PS1+='$(__git_ps1 " (%s)") \$ '
else
    PS1+='\$ '
fi

# Try to keep environment pollution down, EPA loves us.
unset use_color

# Alias definitions.
if [ -f ~/.aliases ]; then
  . ~/.aliases
elif [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Enable programmable completion if available
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

# up-arrow history
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# suggest package for commands not found
[[ -f /usr/share/doc/pkgfile/command-not-found.bash ]] && . /usr/share/doc/pkgfile/command-not-found.bash

# fzf bash integration
eval "$(fzf --bash)"
