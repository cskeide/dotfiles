#
# ~/.bash_aliases
#

# ls aliases
alias la='ls -A'
alias ll='ls -lAh'

# Set 'vi' and 'vim' aliases based on availability
if command -v nvim >/dev/null 2>&1; then
  alias vi='nvim'
  alias vim='nvim'
elif command -v vim >/dev/null 2>&1; then
  alias vi='vim'
fi

# Privileged access
if ((UID != 0)); then
  alias sudo='sudo '
  alias scat='sudo cat'
  alias svim='sudoedit'
  alias root='sudo -i'
  alias reboot='sudo systemctl reboot'
  alias poweroff='sudo systemctl poweroff'
fi

# misc
alias df='df -H'
alias du='du -ch'
alias free='free -h'
alias diff='colordiff'
if command -v difft >/dev/null 2>&1; then
  alias diff='difft'
fi
alias grep='grep --color=auto'
alias more='less'
alias ip='ip -c'

# Safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I' # 'rm -i' prompts for every file
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# RPi
if grep -q Raspberry /proc/cpuinfo; then
  alias temp='vcgencmd measure_temp'
fi
