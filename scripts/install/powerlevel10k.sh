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