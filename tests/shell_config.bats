#!/usr/bin/env bats

# =============================================================================
# Shell configuration correctness tests
# =============================================================================

load '_helpers'

setup() {
  ZSH_DIR="$DOTFILES_ROOT/common/zsh/.config/zsh"
  MACOS_ZSH_DIR="$DOTFILES_ROOT/os/macos/zsh/.config/zsh"
}

# -----------------------------------------------------------------------------
# lib.zsh — load_modules sources all files, not just the first
# -----------------------------------------------------------------------------

@test "load_modules sources all files in a directory" {
  local tmpdir
  tmpdir=$(mktemp -d)
  echo 'LOADED_A=1' > "$tmpdir/a.zsh"
  echo 'LOADED_B=1' > "$tmpdir/b.zsh"

  run zsh -c "
    source '$ZSH_DIR/lib.zsh'
    load_modules '$tmpdir'
    echo \"\$LOADED_A \$LOADED_B\"
  "
  rm -rf "$tmpdir"
  [ "$status" -eq 0 ]
  [ "$output" = "1 1" ]
}

@test "load_modules handles missing directory gracefully" {
  run zsh -c "
    source '$ZSH_DIR/lib.zsh'
    load_modules '/nonexistent/path'
    echo 'ok'
  "
  [ "$status" -eq 0 ]
  [[ "$output" == *"ok"* ]]
}

@test "load_module sources a single file" {
  local tmpfile
  tmpfile=$(mktemp /tmp/test_module.XXXXXX)
  echo 'LOADED_SINGLE=yes' > "$tmpfile"

  run zsh -c "
    source '$ZSH_DIR/lib.zsh'
    load_module '$tmpfile'
    echo \"\$LOADED_SINGLE\"
  "
  rm -f "$tmpfile"
  [ "$status" -eq 0 ]
  [ "$output" = "yes" ]
}

@test "load_module handles missing file gracefully" {
  run zsh -c "
    source '$ZSH_DIR/lib.zsh'
    load_module '/nonexistent/file.zsh'
    echo 'ok'
  "
  [[ "$output" == *"ok"* ]]
}

# -----------------------------------------------------------------------------
# .zprofile does NOT source .zshrc (no double-sourcing)
# -----------------------------------------------------------------------------

@test ".zprofile does not source .zshrc" {
  run grep -c "source.*\.zshrc" "$MACOS_ZSH_DIR/.zprofile"
  [ "$output" = "0" ]
}

# -----------------------------------------------------------------------------
# options.zsh has no duplicate setopt
# -----------------------------------------------------------------------------

@test "options.zsh has no duplicate setopt lines" {
  mapfile -t dupes < <(
    grep '^setopt ' "$ZSH_DIR/config/options.zsh" | sort | uniq -d
  )
  [ "${#dupes[@]}" -eq 0 ] || {
    printf "Duplicate setopt lines:\n"
    printf "  - %s\n" "${dupes[@]}"
    return 1
  }
}

# -----------------------------------------------------------------------------
# completions.zsh does not call brew --prefix
# -----------------------------------------------------------------------------

@test "completions.zsh does not call brew --prefix at startup" {
  run grep "brew --prefix" "$ZSH_DIR/config/completions.zsh"
  [ "$status" -eq 1 ]
}
