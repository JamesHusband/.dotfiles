# ==============================================================================
# Login Shell Configuration (.zprofile)
# ==============================================================================
# This file is sourced for login shells. It should contain commands that
# should run only once per session, like setting up PATH or environment.

# Homebrew (Intel)
if [[ -f "/usr/local/bin/brew" ]]; then
	eval "$(/usr/local/bin/brew shellenv)"
fi

# OrbStack
if [[ -f "/usr/local/bin/orb" ]]; then
	source ~/.orbstack/shell/init.zsh 2>/dev/null || :
fi
