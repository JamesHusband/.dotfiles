# ==============================================================================
# Starhip Prompt Configuration
# ==============================================================================

if [[ ! -s "$XDG_BIN_HOME/starship" ]]; then
  curl -sS https://starship.rs/install.sh | sh -s -- -b "$XDG_BIN_HOME"
fi

export STARSHIP_CACHE=$XDG_CACHE_HOME/starship
export STARSHIP_CONFIG="$ZSH_CONFIG_ROOT/starship.toml"

eval "$(starship init zsh)"