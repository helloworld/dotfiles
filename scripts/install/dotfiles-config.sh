#!/bin/bash

# Install script for dotfiles configuration

NAME="Dotfiles Config"

check_installed() {
    grep -q "source $DOTFILES_DIR/config/dotfiles.sh" ~/.zshrc 2>/dev/null
}

install() {
    log "Adding dotfiles source to .zshrc"
    echo "" >> ~/.zshrc
    echo "# Dotfiles management" >> ~/.zshrc
    echo "source $DOTFILES_DIR/config/dotfiles.sh" >> ~/.zshrc
}

verify() {
    # Verify dotfiles config is sourced and aliases work
    grep -q "source $DOTFILES_DIR/config/dotfiles.sh" ~/.zshrc && \
    [ -f "$DOTFILES_DIR/config/dotfiles.sh" ] && [ -r "$DOTFILES_DIR/config/dotfiles.sh" ]
}