# ==============================================================================
# Development Aliases
# ==============================================================================

# Git aliases (if git is available)
if command -v git >/dev/null 2>&1; then
    alias g="git"
    alias gs="git status"
    alias ga="git add"
    alias gc="git commit"
    alias gp="git push"
    alias gl="git pull"
    alias gd="git diff"
    alias gb="git branch"
    alias gco="git checkout"
fi