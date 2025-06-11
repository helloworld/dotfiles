#!/bin/bash

# Install script for Git configuration

NAME="Git Configuration"

check_installed() {
    [ -n "$(git config --global user.name)" ] && [ -n "$(git config --global user.email)" ]
}

install() {
    log "Setting up Git configuration..."
    
    # Prompt for user details if not already set
    if [ -z "$(git config --global user.name)" ]; then
        echo "Enter your full name for Git commits:"
        read -r git_name
        git config --global user.name "$git_name"
    fi
    
    if [ -z "$(git config --global user.email)" ]; then
        echo "Enter your email for Git commits:"
        read -r git_email
        git config --global user.email "$git_email"
    fi
    
    # Set useful Git defaults
    git config --global init.defaultBranch main
    git config --global pull.rebase false
    git config --global core.autocrlf input
    
    log "Git configuration complete"
}

verify() {
    # Verify Git config is properly set
    [ -n "$(git config --global user.name)" ] && [ -n "$(git config --global user.email)" ]
}