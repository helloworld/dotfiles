#!/bin/bash

# Dotfiles management script
# This file is sourced from .zshrc to set up the environment

DOTFILES_DIR="$HOME/dotfiles"

# Add any custom PATH exports here
export PATH="$PATH:$DOTFILES_DIR/scripts"

# Add any custom aliases here
alias dotfiles-setup="$DOTFILES_DIR/scripts/setup.sh"
alias dotfiles-check="$DOTFILES_DIR/scripts/setup.sh --dry-run"

# Source powerlevel10k if it exists
if [[ -f ~/powerlevel10k/powerlevel10k.zsh-theme ]]; then
    source ~/powerlevel10k/powerlevel10k.zsh-theme
fi

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"