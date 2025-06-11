#!/bin/bash

# Install script for Raycast

NAME="Raycast"

check_installed() {
    [ -d "/Applications/Raycast.app" ]
}

install() {
    log "Installing Raycast..."
    brew install --cask raycast
}