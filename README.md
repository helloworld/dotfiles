# Dotfiles

Personal dotfiles management for macOS.

### Quick Setup
```bash
git clone https://github.com/helloworld/dotfiles.git ~/dotfiles
~/dotfiles/scripts/setup.sh
```

### Commands
- `dotfiles-setup` - Run full setup
- `dotfiles-check` - Dry run check  
- `dotfiles-verify` - Test all installations
- `dotfiles-apps` - Install applications
- `dotfiles-apps-check` - Check app installations

### What's Installed
- Homebrew, NVM, Claude Code, GitHub CLI
- Powerlevel10k theme
- Custom dotfiles config

### Adding Tools
1. Copy `scripts/install/_TEMPLATE.sh` to new file
2. Edit `NAME`, `check_installed()`, `install()`, `verify()` functions  
3. `chmod +x` the new script
4. Test with `dotfiles-check` and `dotfiles-verify`

Scripts auto-discovered from `scripts/install/` directory. The `verify()` function automatically adds testing to CI.