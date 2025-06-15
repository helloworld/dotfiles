.PHONY: help setup check verify apps clean install app new-install new-app

# Colors for output
CYAN := \033[36m
GREEN := \033[32m
YELLOW := \033[33m
RESET := \033[0m

##@ Quick Setup Commands

setup: ## Run full dotfiles setup
	@echo "$(CYAN)Running dotfiles setup...$(RESET)"
	@./scripts/setup.sh

check: ## Check what would be installed (dry run)
	@echo "$(CYAN)Checking installation status...$(RESET)"
	@./scripts/setup.sh --dry-run

verify: ## Verify all installations work
	@echo "$(CYAN)Verifying all installations...$(RESET)"
	@./scripts/setup.sh --verify

apps: ## Install applications
	@echo "$(CYAN)Installing applications...$(RESET)"
	@./scripts/setup.sh --apps

##@ Development Commands

new-install: ## Create new install tool script (usage: make new-install TOOL=toolname)
	@if [ -z "$(TOOL)" ]; then \
		echo "$(YELLOW)Usage: make new-install TOOL=toolname$(RESET)"; \
		echo "$(YELLOW)Example: make new-install TOOL=docker$(RESET)"; \
		exit 1; \
	fi
	@if [ -f "scripts/install/$(TOOL).sh" ]; then \
		echo "$(YELLOW)Tool script scripts/install/$(TOOL).sh already exists!$(RESET)"; \
		exit 1; \
	fi
	@echo "$(CYAN)Creating install script for $(TOOL)...$(RESET)"
	@cp scripts/install/_TEMPLATE.sh scripts/install/$(TOOL).sh
	@sed -i '' 's/Your Tool Name/$(shell echo $(TOOL) | sed 's/.*/\u&/')/' scripts/install/$(TOOL).sh
	@chmod +x scripts/install/$(TOOL).sh
	@echo "$(GREEN)✅ Created scripts/install/$(TOOL).sh$(RESET)"
	@echo "$(YELLOW)📝 Next steps:$(RESET)"
	@echo "   1. Edit scripts/install/$(TOOL).sh"
	@echo "   2. Update check_installed(), install(), and verify() functions"
	@echo "   3. Test with: make check"
	@echo "   4. Install with: make setup"

new-app: ## Create new app script (usage: make new-app APP=appname)
	@if [ -z "$(APP)" ]; then \
		echo "$(YELLOW)Usage: make new-app APP=appname$(RESET)"; \
		echo "$(YELLOW)Example: make new-app APP=discord$(RESET)"; \
		exit 1; \
	fi
	@if [ -f "scripts/apps/$(APP).sh" ]; then \
		echo "$(YELLOW)App script scripts/apps/$(APP).sh already exists!$(RESET)"; \
		exit 1; \
	fi
	@echo "$(CYAN)Creating app script for $(APP)...$(RESET)"
	@sed 's/Your Tool Name/$(shell echo $(APP) | sed 's/.*/\u&/')/g' scripts/install/_TEMPLATE.sh > scripts/apps/$(APP).sh
	@sed -i '' 's/command -v.*>/[ -d "\/Applications\/$(shell echo $(APP) | sed 's/.*/\u&/').app" ]/' scripts/apps/$(APP).sh
	@sed -i '' 's/Installing .*/Installing $(shell echo $(APP) | sed 's/.*/\u&/')..."\n    brew install --cask $(APP)/' scripts/apps/$(APP).sh
	@sed -i '' 's/tool_name --version.*/[ -d "\/Applications\/$(shell echo $(APP) | sed 's/.*/\u&/').app" ]/' scripts/apps/$(APP).sh
	@sed -i '' '/CI_OPTIONAL/d' scripts/apps/$(APP).sh
	@chmod +x scripts/apps/$(APP).sh
	@echo "$(GREEN)✅ Created scripts/apps/$(APP).sh$(RESET)"
	@echo "$(YELLOW)📝 Next steps:$(RESET)"
	@echo "   1. Verify the app name and cask name are correct in scripts/apps/$(APP).sh"
	@echo "   2. Test with: make check"
	@echo "   3. Install with: make apps"

claude-install: ## Generate Claude Code command to create install script
	@if [ -z "$(TOOL)" ]; then \
		echo "$(YELLOW)Usage: make claude-install TOOL=toolname$(RESET)"; \
		echo "$(YELLOW)Example: make claude-install TOOL=docker$(RESET)"; \
		exit 1; \
	fi
	@echo "$(CYAN)Claude Code command to create $(TOOL) install script:$(RESET)"
	@echo ""
	@echo "$(GREEN)claude: First read scripts/install/_TEMPLATE.sh and examine 2-3 existing scripts like scripts/install/homebrew.sh and scripts/install/gh.sh to understand the pattern. Search brew for the correct package name with 'brew search $(TOOL)' to find the right formula. Then create an install script for $(TOOL) by copying the template to scripts/install/$(TOOL).sh and updating the NAME, check_installed(), install(), and verify() functions appropriately. Make it executable and test with the verify command.$(RESET)"
	@echo ""

claude-app: ## Generate Claude Code command to create app script  
	@if [ -z "$(APP)" ]; then \
		echo "$(YELLOW)Usage: make claude-app APP=appname$(RESET)"; \
		echo "$(YELLOW)Example: make claude-app APP=notion$(RESET)"; \
		exit 1; \
	fi
	@echo "$(CYAN)Claude Code command to create $(APP) app script:$(RESET)"
	@echo ""
	@echo "$(GREEN)claude: First read scripts/install/_TEMPLATE.sh and examine 2-3 existing app scripts like scripts/apps/spotify.sh and scripts/apps/slack.sh to understand the pattern. Search brew for the correct cask name with 'brew search --cask $(APP)' to find the right cask. Then create an app install script for $(APP) by copying the template to scripts/apps/$(APP).sh. Update it to use the correct 'brew install --cask' command and check for the correct app name in /Applications/. Make it executable and test with the apps command.$(RESET)"
	@echo ""

##@ Utilities

clean: ## Remove temporary files
	@echo "$(CYAN)Cleaning temporary files...$(RESET)"
	@find . -name "*.bak" -delete 2>/dev/null || true
	@find . -name ".DS_Store" -delete 2>/dev/null || true
	@echo "$(GREEN)✅ Cleaned up temporary files$(RESET)"

list-tools: ## List all available install tools
	@echo "$(CYAN)Available install tools:$(RESET)"
	@ls scripts/install/*.sh 2>/dev/null | sed 's/.*\///;s/\.sh//' | grep -v "_TEMPLATE" | sort

list-apps: ## List all available apps
	@echo "$(CYAN)Available apps:$(RESET)"
	@ls scripts/apps/*.sh 2>/dev/null | sed 's/.*\///;s/\.sh//' | sort

status: ## Show installation status
	@echo "$(CYAN)Current installation status:$(RESET)"
	@./scripts/setup.sh --dry-run --apps

##@ Help

help: ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\n$(CYAN)Dotfiles Management$(RESET)\n\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  $(GREEN)%-15s$(RESET) %s\n", $$1, $$2 } /^##@/ { printf "\n$(YELLOW)%s$(RESET)\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
	@echo ""
	@echo "$(YELLOW)Quick Commands:$(RESET)"
	@echo "  $(GREEN)dots$(RESET)     - Run setup (alias for setup.sh)"
	@echo "  $(GREEN)check$(RESET)    - Dry run check (alias for setup.sh --dry-run)"
	@echo "  $(GREEN)verify$(RESET)   - Test installations (alias for setup.sh --verify)"
	@echo "  $(GREEN)apps$(RESET)     - Install apps (alias for setup.sh --apps)"
	@echo ""