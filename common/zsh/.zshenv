# Zsh directory
export ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"

# XDG Base Directory — exported here so all shell contexts (interactive and non-interactive)
# have these vars before .zshrc loads. env.zsh re-exports them idempotently.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"

