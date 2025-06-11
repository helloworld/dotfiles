#!/bin/bash

# Install script for Google Chrome

NAME="Google Chrome"

check_installed() {
    [ -d "/Applications/Google Chrome.app" ]
}

install() {
    log "Installing Google Chrome..."
    brew install --cask google-chrome
}

verify() {
    # Verify Chrome app exists
    [ -d "/Applications/Google Chrome.app" ]
}