#!/bin/bash

set -e

DOTFILES_DIR="$HOME/dotfiles"
INSTALL_DIR="$DOTFILES_DIR/scripts/install"
APPS_DIR="$DOTFILES_DIR/scripts/apps"
DRY_RUN=false
INSTALL_APPS=false

# Parse arguments
for arg in "$@"; do
    case $arg in
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --apps)
            INSTALL_APPS=true
            shift
            ;;
    esac
done

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

run_install_script() {
    local script_path="$1"
    local script_name=$(basename "$script_path" .sh)
    
    # Source the script to get its functions and variables
    source "$script_path"
    
    if check_installed; then
        log "✅ $NAME already installed"
    else
        if [ "$DRY_RUN" = true ]; then
            log "❌ $NAME NOT installed (would install)"
        else
            install
        fi
    fi
    
    # Clear the variables for the next script
    unset NAME check_installed install
}

main() {
    if [ "$DRY_RUN" = true ]; then
        log "🔍 DRY RUN - Checking installation status..."
    else
        log "Starting dotfiles setup..."
    fi
    
    # Find and run all install scripts in alphabetical order
    for script in "$INSTALL_DIR"/*.sh; do
        if [ -f "$script" ] && [ -x "$script" ]; then
            run_install_script "$script"
        fi
    done
    
    # Install apps if requested
    if [ "$INSTALL_APPS" = true ] && [ -d "$APPS_DIR" ]; then
        log "Installing applications..."
        for script in "$APPS_DIR"/*.sh; do
            if [ -f "$script" ] && [ -x "$script" ]; then
                run_install_script "$script"
            fi
        done
    fi
    
    if [ "$DRY_RUN" = true ]; then
        log "🔍 DRY RUN complete - no changes made"
    else
        log "Setup complete!"
        log "Please restart your terminal or run: source ~/.zshrc"
    fi
}

main "$@"