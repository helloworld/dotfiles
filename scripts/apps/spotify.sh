#!/bin/bash

# Install script for Spotify

NAME="Spotify"

check_installed() {
    [ -d "/Applications/Spotify.app" ]
}

install() {
    log "Installing Spotify..."
    brew install --cask spotify
}

verify() {
    # Verify Spotify app exists
    [ -d "/Applications/Spotify.app" ]
}