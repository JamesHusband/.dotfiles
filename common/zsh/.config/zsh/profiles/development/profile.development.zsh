# ==============================================================================
# Development Profile
# ==============================================================================

[[ ! $DEV_PROFILE ]] && return

# =====================================
# DEVELOPMENT RUNTIMES
# =====================================

# ===============
# Python
# ===============

export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python/__pycache__"

# ===============
# Node.js (nvm)
# ===============

export npm_config_cache="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NVM_DIR="${NVM_DIR:-$XDG_DATA_HOME/nvm}"

# TODO: This implementation needs a serious rethink and refactor

if [[ ! -s "$NVM_DIR/nvm.sh" ]]; then
  mkdir -p "$NVM_DIR"
  # First-time install only; guarded by [[ ! -s ]]. curl|bash is nvm's official method.
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | PROFILE=/dev/null bash
  source "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
  command_exists node || nvm install --lts
else
  # Add default node version to PATH without sourcing NVM.
  () {
    local ver
    ver=$(<"$NVM_DIR/alias/default" 2>/dev/null) || return
    # Follow one level of file-based alias indirection (e.g. default → lts/iron)
    [[ -f "$NVM_DIR/alias/$ver" ]] && ver=$(<"$NVM_DIR/alias/$ver")
    # If still not a concrete version, fall back to newest installed
    if [[ ! "$ver" =~ ^v[0-9] ]]; then
      ver=$(command ls "$NVM_DIR/versions/node/" 2>/dev/null | sort -V | tail -1) || return
    fi
    [[ -d "$NVM_DIR/versions/node/$ver/bin" ]] || return
    export PATH="$NVM_DIR/versions/node/$ver/bin:$PATH"
  }

  # Source NVM only when explicitly needed (version switching, etc.)
  nvm() {
    unset -f nvm
    source "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
    nvm "$@"
  }
fi

# ===============
# Bun
# ===============

export BUN_INSTALL="${BUN_INSTALL:-$XDG_DATA_HOME/bun}"

if [[ ! -x "$BUN_INSTALL/bin/bun" ]]; then
  mkdir -p "$BUN_INSTALL"
  # First-time install only; guarded by [[ ! -x ]]. curl|bash is bun's official method.
  curl -fsSL https://bun.com/install | HOME=/tmp ZDOTDIR=/tmp bash
fi

export PATH="$BUN_INSTALL/bin:$PATH"

[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"


# # TODO: Error on fresh install: no such file or directory: /Users/jam/.cargo/env
# . "$HOME/.cargo/env"


########################################################################################


# Agent Config & Tooling
# ==============================================================================

# Agent Env Vars
# source $ZDOTDIR/profiles/development/development.env

# ======================================
# Claude Code
# ======================================

# ===============
# Rust Token Killer (https://www.rtk-ai.app)
# ===============

RTK_TEE_DIR="$XDG_BIN_HOME/rtk/tee"

if [[ ! -d "$RTK_TEE_DIR" ]]; then
    mkdir -p "$RTK_TEE_DIR"
    command_exists rtk || brew install rtk
    export RTK_HOOK_AUDIT=1
    export RTK_TELEMETRY_DISABLED=1
    export RTK_TEE_DIR
fi

# ===============
# ccstatusline - Claude Code status line (https://github.com/nicholasgasior/ccstatusline)
# ===============

if ! command_exists ccstatusline; then
  bunx -y ccstatusline@latest
fi

# ===============
# CCUSAGE - Token Usage (https://ccusage.com/guide)
# ===============

alias ccusage="bunx ccusage"


# ===============
# ClaudeMonitor - Usage Analytics (https://github.com/Maciek-roboblog/Claude-Code-Usage-Monitor)
# ===============

alias claudmon="claude-monitor"

# ======================================
# Custom System Prompts
# ======================================

# alias claudeautoplan claude --append-system-prompt "$(cat /Users/jam/.claude/system-prompts/auto-plan.txt)"
