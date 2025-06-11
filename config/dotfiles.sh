#!/bin/bash

# Dotfiles management script
# This file is sourced from .zshrc to set up the environment

DOTFILES_DIR="$HOME/dotfiles"

# Add any custom PATH exports here
export PATH="$PATH:$DOTFILES_DIR/scripts"

# Add any custom aliases here
alias dotfiles-setup="$DOTFILES_DIR/scripts/setup.sh"
alias dotfiles-check="$DOTFILES_DIR/scripts/setup.sh --dry-run"
alias dotfiles-verify="$DOTFILES_DIR/scripts/setup.sh --verify"
alias dotfiles-apps="$DOTFILES_DIR/scripts/setup.sh --apps"
alias dotfiles-apps-check="$DOTFILES_DIR/scripts/setup.sh --dry-run --apps"

# Source powerlevel10k if it exists and we're in zsh
if [[ -f ~/powerlevel10k/powerlevel10k.zsh-theme ]] && [[ "$0" == *"zsh"* || -n "$ZSH_VERSION" ]]; then
    source ~/powerlevel10k/powerlevel10k.zsh-theme
fi

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"