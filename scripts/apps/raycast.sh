#!/bin/bash

# Install script for Raycast

NAME="Raycast"
CI_OPTIONAL=true  # This app is optional in CI environments

check_installed() {
    [ -d "/Applications/Raycast.app" ]
}

install() {
    log "Installing Raycast..."
    brew install --cask raycast
}

verify() {
    # Verify Raycast app exists
    [ -d "/Applications/Raycast.app" ]
}