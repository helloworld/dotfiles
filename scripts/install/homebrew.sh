#!/bin/bash

# Install script for Homebrew
# Each install script should define:
# - NAME: Human readable name
# - check_installed(): function that returns 0 if installed, 1 if not
# - install(): function that performs the installation

NAME="Homebrew"

check_installed() {
    command -v brew >/dev/null 2>&1
}

install() {
    log "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}