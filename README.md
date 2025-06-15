# Dotfiles

Personal dotfiles management for macOS.

### Quick Setup
```bash
git clone https://github.com/helloworld/dotfiles.git ~/dotfiles
~/dotfiles/scripts/setup.sh
```

### Quick Commands
- `dots` - Run full setup
- `check` - Dry run check  
- `verify` - Test all installations
- `apps` - Install applications

### Make Commands
- `make help` - Show all available commands
- `make setup` - Run full dotfiles setup
- `make check` - Check installation status
- `make verify` - Verify all installations work
- `make apps` - Install applications
- `make new-app APP=name` - Create new app script
- `make new-install TOOL=name` - Create new install script
- `make claude-app APP=name` - Generate Claude command for app
- `make claude-install TOOL=name` - Generate Claude command for tool

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