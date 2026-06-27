# ==============================================================================
# PATH Configuration
# ==============================================================================

# User binaries (highest priority)
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.jam-sys/bin:$PATH"

# Platform-specific paths
case "$OS" in
    macos)
        export PATH="/usr/local/bin:$PATH"
        export PATH="/usr/local/sbin:$PATH"
        export PATH="$HOME/.codeium/windsurf/bin:$PATH"
        export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
        ;;
    arch|debian)
        export PATH="/usr/share/code/bin:$PATH"
        ;;
esac

# Remove duplicate paths (keeping first occurrence)
typeset -U path
