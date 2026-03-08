# fnm (Fast Node Manager)
export PATH="$HOME/.local/share/fnm:$PATH"
if command -v fnm &> /dev/null; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi
