# VSCode Shell Integration
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

# Flutter
[ -d "$HOME/.local/flutter/bin" ] && PATH="$HOME/.local/flutter/bin:$PATH"

# Android SDK
export ANDROID_HOME="$HOME/Android/Sdk"
export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"
export PATH

# Java
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk"
export QT_QPA_PLATFORM=xcb
