#!/bin/bash

# Install script template
# Copy this file and rename it to add a new installation script
# The setup.sh will automatically discover and run all .sh files in this directory

NAME="Your Tool Name"
# CI_OPTIONAL=true  # Uncomment if this tool should not fail CI when missing

check_installed() {
    # Return 0 if installed, 1 if not installed
    # Examples:
    # command -v tool_name >/dev/null 2>&1              # Check if command exists
    # [ -d "$HOME/.tool_dir" ]                          # Check if directory exists
    # [ -f "$HOME/.tool_config" ]                       # Check if file exists
    # brew list tool_name >/dev/null 2>&1               # Check if brew package installed
    
    return 1  # Replace with actual check
}

install() {
    # Installation commands go here
    # The log function is available for consistent output
    
    log "Installing Your Tool Name..."
    # Add installation commands here
    
    # Examples:
    # brew install tool_name
    # npm install -g tool_name
    # curl -fsSL https://example.com/install.sh | bash
    # git clone https://github.com/user/repo.git ~/tool_name
}

verify() {
    # Verify the installation actually works
    # This function is run during --verify mode to test the installation
    # Return 0 if verification passes, 1 if it fails
    
    # Examples:
    # tool_name --version >/dev/null 2>&1               # Check if tool runs
    # test -r "$HOME/.tool_config"                      # Check if config is readable
    # tool_name test-command >/dev/null 2>&1            # Run a test command
    
    return 0  # Replace with actual verification
}