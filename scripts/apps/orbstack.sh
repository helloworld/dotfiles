#!/bin/bash

# Install script for OrbStack

NAME="OrbStack"

check_installed() {
    [ -d "/Applications/OrbStack.app" ]
}

install() {
    log "Installing OrbStack..."
    brew install --cask orbstack
}

verify() {
    # Verify OrbStack app exists
    [ -d "/Applications/OrbStack.app" ]
}