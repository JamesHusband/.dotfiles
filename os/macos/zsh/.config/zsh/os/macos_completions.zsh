# ==============================================================================
# MacOS Completions
# ==============================================================================

# Homebrew site-functions (for _brew and other brew-managed completions)
if [[ -d "/usr/local/share/zsh/site-functions" ]]; then
    fpath=("/usr/local/share/zsh/site-functions" $fpath)
fi

# Mole completion (cached to avoid startup hit on regeneration)
if command -v mole >/dev/null 2>&1; then
    local mole_cache="$XDG_CACHE_HOME/zsh/_mole"
    if [[ ! -f "$mole_cache" || ! -s "$mole_cache" ]]; then
        mole completion zsh > "$mole_cache" 2>/dev/null || rm -f "$mole_cache"
    fi
    [[ -f "$mole_cache" ]] && source "$mole_cache" 2>/dev/null
fi

# Zoxide shell integration (must run after compinit)
if command -v zoxide >/dev/null 2>&1; then
    local _zoxide_cache="$XDG_CACHE_HOME/zsh/zoxide-init.zsh"
    if [[ ! -f "$_zoxide_cache" ]] || [[ "$(command -v zoxide)" -nt "$_zoxide_cache" ]]; then
        zoxide init zsh > "$_zoxide_cache"
    fi
    source "$_zoxide_cache"
fi
