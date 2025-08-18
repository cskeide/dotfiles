# ~/.profile -- for login shells (POSIX)
# Environment vars only, no aliases or shell-specific stuff.

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
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

# Locale (if not set system-wide)
export LANG=en_US.UTF-8

# Source user bashrc if bash is the shell
if [ -n "$BASH_VERSION" ]; then
    [ -r "$HOME/.bashrc" ] && . "$HOME/.bashrc"
fi

