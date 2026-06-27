# Dotfiles

Personal configuration files managed with GNU Stow.

Each top-level package directory mirrors the path that should exist under
`$HOME`. Stow creates symlinks from the home directory back to the files in this
repository, so the tracked copy remains authoritative while applications read
from their normal locations.

For example:

```text
common/zsh/.zshenv
common/zsh/.config/zsh/.zshrc
```

projects as:

```text
~/.zshenv
~/.config/zsh/.zshrc
```

## Package Layout

```text
common/      shared packages used on every supported OS
os/macos/    macOS-specific packages
os/debian/   Debian-specific packages
os/arch/     Arch-specific packages
cli/         command implementation and shared logic
tests/       Bats tests
```

A package is any direct child directory under `common/` or `os/<name>/`.
Package names are grouped by tool or concern, such as `zsh`, `git`, `ssh`,
`tmux`, `ghostty`, or `yabai`.

## Applying Packages

Use the helper command to apply the shared packages and the current OS-specific
packages:

```sh
dotfiles apply
```

The equivalent Stow operation is:

```sh
stow --target="$HOME" --dir=common --ignore=.DS_Store <package>
stow --target="$HOME" --dir=os/<name> --ignore=.DS_Store <package>
```

The helper applies all available packages from both roots. Common packages are
applied first, followed by the detected OS package root.

## Inspecting State

List available packages:

```sh
dotfiles list
```

Check projected symlinks and required tools:

```sh
dotfiles doctor
```

`doctor` reports missing, broken, or foreign paths where the file in `$HOME`
does not point back to the expected package file.

## Adding A File

Place the file inside the package at the same relative path it should have under
`$HOME`.

Example for a shared Git config:

```text
common/git/.config/git/config
```

Example for a macOS-only shell profile:

```text
os/macos/zsh/.config/zsh/.zprofile
```

After adding or moving files, run:

```sh
dotfiles apply
dotfiles doctor
```
