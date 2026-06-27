#!/usr/bin/env bats

load '_helpers'

@test "critical files exist" {
  file_exists ".stowrc"
  file_exists "cli/package.json"
  file_exists "cli/tsconfig.json"
  file_exists "cli/src/commands/dotfiles/apply.ts"
  file_exists "cli/src/commands/dotfiles/doctor.ts"
  file_exists "cli/src/commands/dotfiles/list.ts"
}

@test "package is an oclif plugin" {
  run node -e "
    const pkg = require('$DOTFILES_ROOT/cli/package.json')
    if (pkg.name !== 'bobos-plugin-dotfiles') process.exit(1)
    if (!pkg.oclif || pkg.oclif.commands !== './dist/src/commands') process.exit(1)
  "
  [ "$status" -eq 0 ]
}

@test "required package directories exist" {
  dir_exists "common/zsh"
  dir_exists "common/git"
  dir_exists "common/ssh"
  dir_exists "common/ghostty"
  dir_exists "os/macos"
}

@test "zsh config structure is intact" {
  file_exists "common/zsh/.config/zsh/.zshrc"
  file_exists "common/zsh/.zshenv"
  file_exists "common/zsh/.config/zsh/lib.zsh"
  file_exists "common/zsh/.config/zsh/env.zsh"
  file_exists "common/zsh/.config/zsh/path.zsh"
  file_exists "common/zsh/.config/zsh/profiles/jamsys/profile.jamsys.zsh"
  file_exists "common/zsh/.config/zsh/profiles/development/profile.development.zsh"
}

@test "dotfiles plugin commands are namespaced under dotfiles" {
  mapfile -t commands < <(
    find "$DOTFILES_ROOT/cli/src/commands/dotfiles" -type f -name '*.ts' \
      | sed "s|^$DOTFILES_ROOT/cli/src/commands/||" \
      | sort
  )

  [ "${commands[*]}" = "dotfiles/apply.ts dotfiles/doctor.ts dotfiles/list.ts" ]
}
