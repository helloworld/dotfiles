#!/bin/bash

# Install script for 1Password

NAME="1Password"

check_installed() {
    [ -d "/Applications/1Password.app" ]
}

install() {
    log "Installing 1Password..."
    brew install --cask 1password
}

verify() {
    # Verify 1Password app exists
    [ -d "/Applications/1Password.app" ]
}