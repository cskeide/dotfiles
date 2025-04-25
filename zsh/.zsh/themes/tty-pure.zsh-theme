autoload -U colors && colors

git_info() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
  if git status --porcelain 2>/dev/null | grep -q .; then
    echo "%{$fg[magenta]%}[$branch*]%{$reset_color%}"
  else
    echo "%{$fg[magenta]%}[$branch]%{$reset_color%}"
  fi
}

precmd() {
  local exit_code=$?

  # Set exit status if non-zero
  if [[ $exit_code -ne 0 ]]; then
    local exitstatus="%{$fg[red]%}x$exit_code%{$reset_color%}"
  else
    local exitstatus=""
  fi

  local git="$(git_info)"

  # Compose prompt dynamically each time
  PROMPT="${exitstatus}
  %{$fg_bold[blue]%}%~ ${git}
  %{$fg_bold[green]%}>%{$reset_color%} "

  # Optional: keep RPROMPT static
  RPROMPT="%{$fg[cyan]%}%*%{$reset_color%}"
}

