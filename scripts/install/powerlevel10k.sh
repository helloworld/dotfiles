#!/bin/bash

# Install script for Powerlevel10k

NAME="Powerlevel10k"

check_installed() {
    [ -d "$HOME/powerlevel10k" ]
}

install() {
    log "Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
}

verify() {
    # Verify Powerlevel10k theme file exists and is readable
    [ -f "$HOME/powerlevel10k/powerlevel10k.zsh-theme" ] && [ -r "$HOME/powerlevel10k/powerlevel10k.zsh-theme" ]
}