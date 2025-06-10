#!/bin/bash

# Install script for NVM (Node Version Manager)

NAME="NVM"

check_installed() {
    [ -d "$HOME/.nvm" ]
}

install() {
    log "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    log "Installing latest Node.js..."
    nvm install node
    nvm use node
}