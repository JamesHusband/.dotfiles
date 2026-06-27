# ==============================================================================
# System Aliases
# ==============================================================================

# Debian renames (batcat → bat, fdfind → fd)
if command -v batcat >/dev/null 2>&1 && ! command -v bat >/dev/null 2>&1; then
    alias bat="batcat"
fi
if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
    alias fd="fdfind"
fi

# System information
alias ps="ps aux"
alias top="htop"  # if htop is installed, falls back to top
alias grep="grep --color=auto"

# Network
alias ping="ping -c 4"
alias ports="netstat -tuln"

