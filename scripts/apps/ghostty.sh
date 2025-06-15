#!/bin/bash

# Install script for Ghostty Terminal

NAME="Ghostty Terminal"
CI_OPTIONAL=true  # This app is optional in CI environments

check_installed() {
    [ -d "/Applications/Ghostty.app" ]
}

install() {
    log "Installing Ghostty Terminal..."
    brew install --cask ghostty
}

verify() {
    # Verify Ghostty app exists
    [ -d "/Applications/Ghostty.app" ]
}