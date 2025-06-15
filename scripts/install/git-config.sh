#!/bin/bash

# Install script for Git configuration

NAME="Git Configuration"

check_installed() {
    [ -n "$(git config --global user.name)" ] && [ -n "$(git config --global user.email)" ]
}

install() {
    log "Setting up Git configuration..."
    
    # Set default values for helloworld account
    if [ -z "$(git config --global user.name)" ]; then
        if [ "$CI" = true ]; then
            # In CI, use default values
            git config --global user.name "Sashank Thupukari"
            git config --global user.email "3893054+helloworld@users.noreply.github.com"
        else
            echo "Enter your full name for Git commits (default: Sashank Thupukari):"
            read -r git_name
            git_name=${git_name:-"Sashank Thupukari"}
            git config --global user.name "$git_name"
        fi
    fi
    
    if [ -z "$(git config --global user.email)" ]; then
        if [ "$CI" = true ]; then
            # In CI, use default values
            git config --global user.email "3893054+helloworld@users.noreply.github.com"
        else
            echo "Enter your email for Git commits (default: 3893054+helloworld@users.noreply.github.com):"
            read -r git_email
            git_email=${git_email:-"3893054+helloworld@users.noreply.github.com"}
            git config --global user.email "$git_email"
        fi
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