# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Better history handling
HISTCONTROL=ignoredups:erasedups:ignorespace
HISTSIZE=50000
HISTFILESIZE=200000
HISTIGNORE="ls:ll:la:l:cd:pwd:exit:clear"
shopt -s histappend # append instead of overwrite
shopt -s cmdhist    # multi-line commands as one entry
shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -s nocaseglob
bind "set completion-ignore-case on"

# Share history across terminals
PROMPT_COMMAND="history -a; history -c; history -r; ${PROMPT_COMMAND:-:}"

if command -v dircolors >/dev/null 2>&1; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors
	if [[ -f ~/.dir_colors ]]; then
		eval "$(dircolors -b ~/.dir_colors)"
	elif [[ -f /etc/DIR_COLORS ]]; then
		eval "$(dircolors -b /etc/DIR_COLORS)"
	else
		eval "$(dircolors -b)"
	fi

	if [[ ${EUID} -eq 0 ]]; then
		PS1='\[\033[01;31m\]\h\[\033[01;34m\] \w\[\033[00m\]'
	else
		PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[00m\]'
	fi

	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias egrep='egrep --color=auto'
	alias fgrep='fgrep --color=auto'
else
	# show root@ when we don't have colors
	PS1='\u@\h \w'
fi

if [ -f /usr/share/git/git-prompt.sh ]; then
	source /usr/share/git/git-prompt.sh
	PS1+='$(__git_ps1 " (%s)") \$ '
else
	PS1+=' \$ '
fi

# Alias definitions.
if [ -f ~/.aliases ]; then
	. "$HOME/.aliases"
elif [ -f ~/.bash_aliases ]; then
	. "$HOME/.bash_aliases"
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
