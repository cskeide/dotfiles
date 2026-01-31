# VSCode Shell Integration
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

# Flutter
[ -d "$HOME/.local/flutter/bin" ] && PATH="$HOME/.local/flutter/bin:$PATH"
export PATH

export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable
