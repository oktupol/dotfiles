# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal dotfiles for an Arch Linux + Sway (Wayland) desktop. Configuration lives under `home/`, which mirrors `$HOME`. Files are deployed by symlinking from this repo into the home directory, so editing a tracked file here directly affects the live system once symlinks exist.

## Commands

- `./create_symlinks.sh` — Deploy configs by symlinking `home/` contents into `$HOME`. Idempotent: replaces existing symlinks, but never overwrites real (non-symlink) files.
- `./install_dependencies.sh` — `pacman -S` the desktop stack (sway, waybar, wofi, kitty, etc.) and clone Powerlevel10k into oh-my-zsh's custom themes.
- `git submodule update --init` — Fetch oh-my-zsh (it is a git submodule at `home/.oh-my-zsh`, not tracked content).
- Build a custom package: `cd packages/<name> && makepkg -si`. After editing a packaged source file, regenerate hashes with `updpkgsums` (or `makepkg -g`) and bump `pkgver`/`pkgrel` in the `PKGBUILD`, since `sha256sums` are checked at build time.

## Symlink model (important when adding files)

`create_symlinks.sh` only iterates the immediate children of three explicitly listed directories: `home`, `home/.config`, and `home/.config/systemd/user`. It strips the leading `home/` to compute each target under `$HOME`.

Consequences:
- A whole `.config` subdirectory (e.g. `home/.config/sway`) is symlinked as a single directory link. New files added *inside* an already-linked directory appear automatically — no re-run needed.
- A brand-new top-level dir like `home/.config/newapp` requires re-running the script, and it will be linked as a whole directory.
- `home/.config/systemd/user` is special-cased to link *per file* rather than as a directory, because other tools also write unit files into `~/.config/systemd/user`. Add new `from_paths` entries in the script when a directory needs the same per-file granularity instead of a directory-level link.

## Shell configuration

- `home/.zshrc` is the standard oh-my-zsh + Powerlevel10k bootstrap. Keep personal changes out of it; it sources `home/.zshrc.custom` at the end.
- `home/.zshrc.custom` holds all custom env vars, aliases, PATH additions, and conditional completions. This is the file to edit for shell customization.
- Prompt config is split by terminal: `.p10k-linux.zsh` for the bare TTY (`TERM=linux`), `.p10k-xterm.zsh` otherwise.
- `home/.bin` is prepended to `PATH`; scripts placed there become commands. Some `.bin` scripts (e.g. `mount_paperless`) are gitignored as machine-specific.

## Custom scripts (`home/.bin`)

Sway/Wayland helpers that drive the desktop by querying `swaymsg -t get_tree` and parsing with `jq` (e.g. `sway_get_focused_cwd`, `wofi_sway_scratchpad`), plus utilities like `pactl-safe-volume-up` (caps volume at the sink base volume) and `show-wifi-passwords`. Follow the existing pattern when adding desktop integrations: query state via the relevant CLI, filter with `jq`/`awk`.

## Packages (`packages/`)

Locally maintained Arch packages (prefix `oktupol-`) installed via `makepkg`, used for system-level tweaks that don't belong in `home/` — getty/login behavior and a systemd sleep hook for nouveau. Built artifacts (`src/`, `pkg/`, `*.tar.zst`) are gitignored.
