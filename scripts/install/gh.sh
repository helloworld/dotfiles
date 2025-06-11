#!/bin/bash

# Install script for GitHub CLI

NAME="GitHub CLI"

check_installed() {
    command -v gh >/dev/null 2>&1
}

install() {
    log "Installing GitHub CLI..."
    brew install gh
}

verify() {
    # Verify GitHub CLI works
    gh --version >/dev/null 2>&1
}