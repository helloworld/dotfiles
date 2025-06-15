#!/bin/bash

# Install script for Slack

NAME="Slack"

check_installed() {
    [ -d "/Applications/Slack.app" ]
}

install() {
    log "Installing Slack..."
    brew install --cask slack
}

verify() {
    # Verify Slack app exists
    [ -d "/Applications/Slack.app" ]
}