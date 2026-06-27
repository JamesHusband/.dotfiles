# ==============================================================================
# Environment Variables
# ==============================================================================

# ======================================
# System
# ======================================

export EDITOR="code -w"
export VISUAL="$EDITOR"

export LANG="en_GB.UTF-8"
export LC_ALL="en_GB.UTF-8"

# ======================================
# XDG Base Directory
# ======================================

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/tmp}"
export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"

# ======================================
# BobOS
# ======================================

export BOBOS="/Volumes/BobOS"
. "$BOBOS/env/load.sh"

# ======================================
# Claude Code
# ======================================

export BASH_MAX_OUTPUT_LENGTH=15000

# ======================================
# ZSH
# ======================================

export ZSH_CONFIG_ROOT="${ZSH_CONFIG_ROOT:-$XDG_CONFIG_HOME/zsh/config}"

export HISTFILE="$XDG_STATE_HOME/zsh/history"
export HISTSIZE=10000
export SAVEHIST=10000
mkdir -p "$XDG_STATE_HOME/zsh"

# ======================================
# Machine Identity
# ======================================

_jamsys_state="$XDG_STATE_HOME/jamsys"
[[ -f "$_jamsys_state/os" ]]       && export OS="$(<"$_jamsys_state/os")"
[[ -f "$_jamsys_state/hostname" ]] && export MACHINE="$(<"$_jamsys_state/hostname")"
unset _jamsys_state
