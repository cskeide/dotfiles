# Copilot Instructions

## Repository Overview

GNU Stow-based dotfiles for Arch Linux with a Hyprland desktop environment. Each top-level directory is a **stow package** — its internal structure mirrors `$HOME`. Running `stow <package>` creates symlinks from the package into `~`.

```
nvim/.config/nvim/init.lua  →  ~/.config/nvim/init.lua
zsh/.zshrc                  →  ~/.zshrc
bash/.aliases               →  ~/.aliases
```

## Managing Packages

```bash
# Stow a single package
stow zsh

# Unstow a package
stow -D zsh

# Stow all packages (also backs up existing files)
./install.sh
```

## Architecture

### Stow Package Layout
Every package directory uses the exact home-relative path. When adding a new config file, place it at `<package>/<path-relative-to-home>`. The package name itself is arbitrary — it's just a grouping.

### Zsh — Modular Config
`zsh/.zshrc` is minimal; it sources files from `zsh/.zsh/`:
- `plugins.zsh` — zinit plugin manager + all plugins (use `zsh-defer` for slow/non-essential plugins)
- `keybinds.zsh` — key bindings
- `nvm.zsh` — Node version manager lazy-load
- `prompt.zsh` — prompt configuration
- `dev.zsh` — dev tool exports/aliases

Plugins are managed with [zinit](https://github.com/zdharma-continuum/zinit). Slower plugins are loaded with `zsh-defer`.

### Theme System (Hyprland ecosystem)
Two themes are supported: **catppuccin** (mocha) and **tokyonight**. The active theme is tracked in `hypr/.config/hypr/.current-theme`.

Theme files follow the naming convention:
- `style-catppuccin.css` / `style-tokyonight.css`
- `colors-catppuccin.css` / `colors-tokyonight.css`
- `mocha.conf` / `tokyonight.conf`

Switching themes updates symlinks and patches config files via `sed`. The script that orchestrates this is `hypr/.config/hypr/scripts/theme-switch.sh`. **When adding a new themed component, add it to this script.**

Active theme symlinks (e.g., `theme.conf`, `colors.css`, `style.css`) are not committed — they are created by `theme-switch.sh` at runtime.

### Host-Specific Hyprland Config
Machine-specific monitor and input configs live in:
```
hypr/.config/hypr/host-files.<hostname>/
  inputs.conf
  monitors.conf
```
The `host-files` symlink (gitignored) points to the active host directory. To add a new machine, create a new `host-files.<hostname>/` directory.

## Key Conventions

- **Catppuccin Mocha** is the default/primary theme variant for all tools that only support one theme.
- **`.gitignore`** excludes `hypr/.config/hypr/host-files` (the active host symlink), `.gitconfig`, and `.luarc.json`.
- The `environment.d/` files in the hypr package set system-wide environment variables for the Wayland session (locale, PATH, editor, etc.).
- Neovim config is based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and uses lazy.nvim (lock file: `lazy-lock.json`). Formatting is configured via `.stylua.toml`.
