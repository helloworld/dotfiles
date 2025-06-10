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