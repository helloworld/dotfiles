# Dotfiles

Personal dotfiles management system for macOS setup.

## Quick Setup

```bash
git clone <your-repo-url> ~/dotfiles
~/dotfiles/scripts/setup.sh
```

## Commands

- `dotfiles-setup` - Run the full setup script
- `dotfiles-check` - Check what would be installed (dry run)

## What's Installed

- Homebrew
- NVM (Node Version Manager) with latest Node.js
- Claude Code
- Powerlevel10k theme for Zsh
- Custom dotfiles configuration

## Adding New Tools

To add a new tool installation:

1. Copy `scripts/install/_TEMPLATE.sh` to a new file (e.g., `scripts/install/git.sh`)
2. Edit the `NAME`, `check_installed()`, and `install()` functions
3. Make it executable: `chmod +x scripts/install/git.sh`
4. Test with: `dotfiles-check`

The setup script automatically discovers and runs all `.sh` files in the `scripts/install/` directory.