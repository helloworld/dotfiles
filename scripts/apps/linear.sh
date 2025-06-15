#!/bin/bash

# Install script for Linear

NAME="Linear"

check_installed() {
    [ -d "/Applications/Linear.app" ]
}

install() {
    log "Installing Linear..."
    brew install --cask linear-linear
}

verify() {
    # Verify Linear app exists
    [ -d "/Applications/Linear.app" ]
}