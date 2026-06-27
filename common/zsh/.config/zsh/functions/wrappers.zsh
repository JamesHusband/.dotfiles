# ==============================================================================
# Command Wrappers
# ==============================================================================

# Package Installer Logging
# ==============================================================================
#
## Package installation interception layer for state tracking.
#
## Captures state-mutating installs from supported package managers
## and records untracked installations for later reconciliation with
## jam-sys manifests.
#
## This layer is intentionally incomplete; it prioritises explicit
## install actions over full system observability to preserve control
## over governance boundaries and avoid false positives from passive
## scanning or non-mutating commands.
#
## Supported surfaces:
## - brew install (formula + cask)
## - npm global installs (-g only)
## - curl | bash / sh (best-effort detection only)
#
# ======================================
# Brew wrapper (state-mutating only)
# ======================================

brew() {

  command brew "$@"

  if [[ "$1" == "install" ]]; then
    shift

    for pkg in "$@"; do
      jsrecord brew "$pkg"
    done
  fi
}

# ======================================
# NPM wrapper (global installs only)
# ======================================

npm() {
  command npm "$@"

  if [[ "$1" == "install" || "$1" == "i" ]] && [[ "$*" == *"-g"* ]]; then
    local args=("$@")

    local pkgs=()

    for arg in "${args[@]}"; do
      [[ "$arg" == -* ]] && continue
      [[ "$arg" == "install" || "$arg" == "i" ]] && continue
      [[ "$arg" == "-g" ]] && continue
      pkgs+=("$arg")
    done

    for pkg in "${pkgs[@]}"; do
      jsrecord npm "$pkg"
    done
  fi
}

# ======================================
# Curl wrapper (best-effort logs only)
# ======================================

curl() {
  command curl "$@"

  # only log obvious installer patterns
  if [[ "$*" == *"| bash"* ]] || [[ "$*" == *"| sh"* ]]; then
    jsrecord curl "$*"
  fi
}

#
# ==============================================================================
