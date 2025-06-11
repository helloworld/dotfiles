#!/bin/bash

# Install script for Claude Code

NAME="Claude Code"

check_installed() {
    command -v claude >/dev/null 2>&1
}

install() {
    log "Installing Claude Code..."
    npm install -g @anthropic-ai/claude-code
}

verify() {
    # Verify Claude Code works
    claude --version >/dev/null 2>&1
}