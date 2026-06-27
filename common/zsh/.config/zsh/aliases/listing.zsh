# ==============================================================================
# Listing Aliases
# ==============================================================================

# Enhanced ls — use eza if available
if command -v eza >/dev/null 2>&1; then
    alias ls="eza"
    alias ll="eza -alF"
    alias la="eza -a"
    alias l="eza -F"
    alias lsd="eza -D"
    alias tree="eza --tree"
elif [[ "$(uname -s)" == "Darwin" ]]; then
    alias ls="ls -G"
    alias ll="ls -alFG"
    alias la="ls -AG"
    alias l="ls -CFG"
    alias lsd="ls -d */"
    alias tree="tree -C"
else
    alias ls="ls --color=auto"
    alias ll="ls -alF --color=auto"
    alias la="ls -A --color=auto"
    alias l="ls -CF --color=auto"
    alias lsd="ls -d */"
    alias tree="tree -C"
fi
