#!/bin/bash

set -e

DOTFILES_DIR="$HOME/dotfiles"
INSTALL_DIR="$DOTFILES_DIR/scripts/install"
APPS_DIR="$DOTFILES_DIR/scripts/apps"
DRY_RUN=false
INSTALL_APPS=false
VERIFY_MODE=false

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
        --verify)
            VERIFY_MODE=true
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
    unset NAME check_installed install verify CI_OPTIONAL
}

run_verify_script() {
    local script_path="$1"
    local script_name=$(basename "$script_path" .sh)
    
    # Source the script to get its functions and variables
    source "$script_path"
    
    if ! check_installed; then
        # Check if this is optional in CI and we're in CI
        if [ "$CI_OPTIONAL" = true ] && [ "$CI" = true ]; then
            log "⚠️  $NAME not installed (optional in CI)"
            unset NAME check_installed install verify CI_OPTIONAL
            return 0  # Don't count as failure
        else
            log "❌ $NAME not installed - skipping verification"
            unset NAME check_installed install verify CI_OPTIONAL
            return 1
        fi
    fi
    
    if declare -f verify >/dev/null 2>&1; then
        if verify; then
            log "✅ $NAME verification passed"
        else
            log "❌ $NAME verification FAILED"
            unset NAME check_installed install verify CI_OPTIONAL
            return 1
        fi
    else
        log "⚠️  $NAME has no verification function"
    fi
    
    # Clear the variables for the next script
    unset NAME check_installed install verify CI_OPTIONAL
}

main() {
    if [ "$VERIFY_MODE" = true ]; then
        log "🔍 VERIFY MODE - Testing all installations..."
        local failed=0
        
        # Verify all install scripts
        for script in "$INSTALL_DIR"/*.sh; do
            if [ -f "$script" ] && [ -x "$script" ] && [[ "$(basename "$script")" != "_TEMPLATE.sh" ]]; then
                if ! run_verify_script "$script"; then
                    failed=$((failed + 1))
                fi
            fi
        done
        
        # Verify apps if they exist
        if [ -d "$APPS_DIR" ]; then
            for script in "$APPS_DIR"/*.sh; do
                if [ -f "$script" ] && [ -x "$script" ] && [[ "$(basename "$script")" != "_TEMPLATE.sh" ]]; then
                    if ! run_verify_script "$script"; then
                        failed=$((failed + 1))
                    fi
                fi
            done
        fi
        
        if [ $failed -eq 0 ]; then
            log "✅ All verifications passed!"
            exit 0
        else
            log "❌ $failed verification(s) failed!"
            exit 1
        fi
    elif [ "$DRY_RUN" = true ]; then
        log "🔍 DRY RUN - Checking installation status..."
    else
        log "Starting dotfiles setup..."
    fi
    
    # Find and run all install scripts in alphabetical order
    for script in "$INSTALL_DIR"/*.sh; do
        if [ -f "$script" ] && [ -x "$script" ] && [[ "$(basename "$script")" != "_TEMPLATE.sh" ]]; then
            run_install_script "$script"
        fi
    done
    
    # Install apps if requested
    if [ "$INSTALL_APPS" = true ] && [ -d "$APPS_DIR" ]; then
        log "Installing applications..."
        for script in "$APPS_DIR"/*.sh; do
            if [ -f "$script" ] && [ -x "$script" ] && [[ "$(basename "$script")" != "_TEMPLATE.sh" ]]; then
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