# ==============================================================================
# JamSys Initialization
# ==============================================================================

export JAMSYS_ROOT="${JAMSYS_ROOT:-$HOME/.jam-sys}"

# ======================================
# JamSys Aliases
# ======================================

# Open JamSys root directory
alias jamconfig="cd $JAMSYS_ROOT"

# Edit Zsh configuration
alias zshedit="$EDITOR $JAMSYS_ROOT/dotfiles/common/zsh/.config/zsh/"

# ======================================
# Bootstrap Debug Environment
# ======================================

# Loads bootstrap libs into the current shell for testing modules in isolation.
# Usage: jamsys_debug && source bootstrap/modules/04_bitwarden.sh
jamsys_debug() {
  export JAMSYS_ROOT="${JAMSYS_ROOT:-$HOME/.jam-sys}"
  export BOOTSTRAP_DIR="$JAMSYS_ROOT/bootstrap"
  export OS_DIR="$BOOTSTRAP_DIR/os/$OS"
  export LIBS_DIR="$BOOTSTRAP_DIR/lib"

  source "$BOOTSTRAP_DIR/lib/lib.sh"
  LIBS_DIR="$BOOTSTRAP_DIR/lib"
  load_all_libs

  echo "Bootstrap debug environment loaded (OS=$OS, MACHINE=$MACHINE)"
  echo "Source a module with: source \$BOOTSTRAP_DIR/modules/<module>.sh"
}
