#!/usr/bin/env bash

# Colors for status messages
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Helper function to print status messages
print_status() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}" >&2
}

# Helper function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Helper function to check if walker is available
is_walker_available() {
    command_exists "walker"
}

# Helper function to check if walker service is running
is_walker_service_running() {
    # Check for walker process with --gapplication-service argument
    pgrep -f "walker --gapplication-service" >/dev/null
}

# Helper function to check if elephant is running
is_elephant_running() {
    pgrep -x elephant >/dev/null
}

# Helper function to start elephant (either via service or binary)
ensure_elephant_running() {
    if ! is_elephant_running; then
        print_status "$YELLOW" "🐘 Elephant is not running, attempting to start..."
        
        # Check if systemd service exists and try to start it
        if systemctl --user list-unit-files elephant.service &>/dev/null; then
            print_status "$YELLOW" "📦 Found elephant.service, starting via systemd..."
            if systemctl --user start elephant.service; then
                print_status "$GREEN" "✅ Started elephant.service successfully"
            else
                print_status "$RED" "❌ Failed to start elephant.service"
                return 1
            fi
        elif command_exists "elephant"; then
            # Fallback to running the binary directly
            print_status "$YELLOW" "🚀 Starting elephant binary directly..."
            if elephant &>/dev/null & then
                print_status "$GREEN" "✅ Started elephant binary successfully"
            else
                print_status "$RED" "❌ Failed to start elephant binary"
                return 1
            fi
        else
            print_status "$RED" "❌ Elephant not found in PATH and no systemd service available"
            return 1
        fi
    else
        print_status "$GREEN" "✅ Elephant is already running"
    fi
    return 0
}

# Function to launch the application menu
launch_menu() {
    if is_walker_available && ensure_elephant_running; then
        walker
    else
        print_status "$YELLOW" "⚠️  Falling back to wofi..."
        pkill wofi || wofi --conf ~/.config/wofi/config --style ~/.config/wofi/style.css --show drun
    fi
}

# Function to launch the app menu
launch_appmenu() {
    if is_walker_available && ensure_elephant_running; then
        walker -m desktopapplications
    else
        print_status "$YELLOW" "⚠️  Falling back to wofi..."
        pkill wofi || wofi --conf ~/.config/wofi/config --style ~/.config/wofi/style.css --show appmenu
    fi
}

# Function to launch the run menu
launch_runner() {
    if is_walker_available && ensure_elephant_running; then
        walker -m runner
    else
        print_status "$YELLOW" "⚠️  Falling back to wofi..."
        pkill wofi || wofi --conf ~/.config/wofi/config --style ~/.config/wofi/style.css --show run
    fi
}

# Start the launcher service if this script was called without arguments
if [ $# -eq 0 ]; then
    print_status "$YELLOW" "🚀 Initializing launcher services..."
    
    if ! is_walker_available; then
        print_status "$RED" "❌ Walker not found in PATH"
        exit 1
    fi
    
    if ! ensure_elephant_running; then
        print_status "$RED" "❌ Failed to ensure Elephant is running"
        exit 1
    fi

    if is_walker_service_running; then
        print_status "$GREEN" "✅ Walker service is already running"
    else
        print_status "$YELLOW" "🚀 Starting Walker application service..."
        if walker --gapplication-service &>/dev/null & then
            print_status "$GREEN" "✅ Walker service started successfully"
        else
            print_status "$RED" "❌ Failed to start Walker service"
            exit 1
        fi
    fi
    
    print_status "$GREEN" "✨ Launcher services initialized successfully"
    exit 0
fi

# Handle menu/runner launch based on arguments
case "$1" in
    "menu")
        launch_menu
        ;;
    "appmenu")
        launch_appmenu
        ;;
    "run")
        launch_runner
        ;;
    *)
        echo "Usage: $0 [menu|run|appmenu]"
        echo "Without arguments: starts the launcher service"
        exit 1
        ;;
esac