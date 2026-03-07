function lazy_nvm {
  unset -f nvm
  unset -f npm
  unset -f node
  unset -f npx

  # NVM_DIR must be user-writable for storing node versions and aliases
  export NVM_DIR="$HOME/.nvm"
  [ -d "$NVM_DIR" ] || mkdir -p "$NVM_DIR"

  if [ -s "$NVM_DIR/nvm.sh" ]; then
    \. "$NVM_DIR/nvm.sh"  # This loads nvm
  elif [ -s "/usr/share/nvm/nvm.sh" ]; then
    \. "/usr/share/nvm/nvm.sh"  # This loads nvm (pacman)
    [ -s "/usr/share/nvm/bash_completion" ] && \. "/usr/share/nvm/bash_completion"
  fi
}

# aliases
function nvm { lazy_nvm; nvm "$@"; }
function npm { lazy_nvm; npm "$@"; }
function node { lazy_nvm; node "$@"; }
function npx { lazy_nvm; npx "$@"; }
