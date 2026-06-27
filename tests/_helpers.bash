DOTFILES_ROOT="$BATS_TEST_DIRNAME/.."

file_exists()    { [ -f "$DOTFILES_ROOT/$1" ]; }
dir_exists()     { [ -d "$DOTFILES_ROOT/$1" ]; }
is_executable()  { [ -x "$DOTFILES_ROOT/$1" ]; }
has_shebang()    { head -1 "$DOTFILES_ROOT/$1" | grep -q "^#!"; }
uses_strict_mode() { grep -q "set -euo pipefail" "$DOTFILES_ROOT/$1"; }
