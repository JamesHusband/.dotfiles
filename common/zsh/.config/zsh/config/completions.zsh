# ==============================================================================
# Completions Loader
# ==============================================================================

# Ensure cache directory exists
[[ -d "$XDG_CACHE_HOME/zsh" ]] || mkdir -p "$XDG_CACHE_HOME/zsh"

zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

# Initialize completion system once per session (rebuild dump at most once per day)
if [[ -z "$_ZSH_COMPINIT_DONE" ]]; then
    autoload -Uz compinit
    local zcompdump="$XDG_CACHE_HOME/zsh/.zcompdump"
    local -a recent=( "$zcompdump"(Nmh-24) )
    if (( ${#recent} )); then
        compinit -C -d "$zcompdump"
    else
        compinit -d "$zcompdump"
    fi
    export _ZSH_COMPINIT_DONE=1
fi

# ==============================================================================
# Tool-Specific Completions
# ==============================================================================

# Git completion
if command -v git >/dev/null 2>&1; then
    local git_completion="${commands[git]:A:h:h}/share/git-core/contrib/completion/git-completion.zsh"
    [[ -r "$git_completion" ]] && zstyle ':completion:*:*:git:*' script "$git_completion"
fi
