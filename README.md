# Dotfiles

User configuration managed as a BobOS `config` subsystem plugin.

This repository owns dotfile source and projects it into `$HOME` with GNU Stow.
It does not install packages, use `sudo`, apply OS defaults, provision secrets,
or perform machine bootstrap work.

## Commands

The repository is an oclif plugin for the main `bobos` CLI. Link it during
development with:

```sh
bobos plugins link /Volumes/BobOS/subsystems/config/dotfiles/src/cli
```

Then run:

```sh
bobos dotfiles list
bobos dotfiles apply
bobos dotfiles doctor
```

## Layout

```text
common/      shared Stow packages
os/<name>/   OS-specific Stow packages
cli/         oclif plugin commands and shared logic
tests/       Bats tests
```

Supported OS identifiers are `macos`, `debian`, and `arch`.
