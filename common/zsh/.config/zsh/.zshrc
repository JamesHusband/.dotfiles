# ==============================================================================
# ZSH Configuration
# ==============================================================================

source "$ZDOTDIR/lib.zsh"                       # Lib Functions
               
# ======================================
# Shell Config
# ======================================

load_module "$ZDOTDIR/env.zsh"                  # Environment variables
load_module "$ZDOTDIR/path.zsh"                 # Update PATH
load_module "$ZDOTDIR/.env.secrets"             # Local Secrets

# ======================================
# Core Configuration
# ======================================

load_module "$ZSH_CONFIG_ROOT/options.zsh"      # ZSH Settings
load_module "$ZSH_CONFIG_ROOT/bindings.zsh"     # Key Binds
load_module "$ZSH_CONFIG_ROOT/completions.zsh"  # Completions

# ======================================
# Load Modules
# ======================================

load_modules "$ZDOTDIR/os"                      # OS Specific (sets profile flags)
load_modules "$ZDOTDIR/functions"               # Functions
load_modules "$ZDOTDIR/aliases"                 # Aliases
load_profiles "$ZDOTDIR/profiles"               # Domain profiles

# ======================================
#  Plugins
# ======================================

load_module "$ZSH_CONFIG_ROOT/prompt.zsh"       # Starship Prompt Config (must be last)

export PATH="/Users/jam/.vlt/.vault/bin:$PATH" # vault-cli

export BOBOS="/Volumes/BobOS"
. "$BOBOS/env/env.sh"


export CLAUDE_CODE_TMPDIR="$XDG_CACHE_HOME/claude"