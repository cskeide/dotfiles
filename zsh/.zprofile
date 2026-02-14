# Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# PATH adjustments
# Put ~/.local/bin and ~/bin at the front if they exist
for d in "$HOME/.local/bin" "$HOME/bin"; do
	[ -d "$d" ] && PATH="$d:$PATH"
done

export PATH

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

# Less defaults (quality of life)
export LESS=-FRX

# Use systemd-managed ssh-agent
if [ -z "$SSH_AUTH_SOCK" ]; then
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi
