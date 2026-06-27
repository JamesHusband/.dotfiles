# ==============================================================================
# Utility Aliases
# ==============================================================================

# Path utilities
alias path='echo $PATH | tr ":" "\n"'

# History utilities
alias h='history'
alias hg='history | grep'

# Help system - use tealdeer if available, fallback to tldr/man
if command -v tealdeer >/dev/null 2>&1; then
	alias help='tldr'
	alias tldr='tealdeer'
elif command -v tldr >/dev/null 2>&1; then
	alias help='tldr'
fi

# Shell Reload
alias zshreload="source $ZDOTDIR/.zshrc"

# Clear screen
alias c="clear"
