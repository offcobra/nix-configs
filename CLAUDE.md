# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A NixOS flake managing multiple machines and Home Manager configurations for user `wally`. All system/user config is declarative Nix; there is no build step beyond `nixos-rebuild` or `home-manager switch`.

## Key Commands

```bash
# Rebuild NixOS system (wraps nixos-rebuild, prompts before applying)
nh os switch --ask --update     # alias: os-rebuild

# Rebuild Home Manager config
nh home switch                  # alias: hm-rebuild

# Clean old generations (keep 3)
nh clean all --keep 3           # alias: nix-clean

# Rebuild + clean everything
update                          # alias: runs os-rebuild && hm-rebuild && nix-clean

# Check flake syntax without applying
nix flake check

# Update flake inputs
nix flake update
```

## Repository Structure

```
flake.nix               — thin entry point; wires flake-parts + import-tree over ./modules
modules/                — DENDRITIC LAYER: every file here is a flake-parts module
  settings.nix          — declares cfg.userSettings + cfg.allowedUnfreePackages options; sets their values
  hosts/
    workstation.nix     — flake.nixosConfigurations.workstation
    thinkpad.nix        — flake.nixosConfigurations.thinkpad
    minipc.nix          — flake.nixosConfigurations.minipc
    mediatv.nix         — flake.nixosConfigurations.mediatv
    studiopc.nix        — flake.nixosConfigurations.studiopc
  home/
    wally.nix           — flake.homeConfigurations.wally
    lisa.nix            — flake.homeConfigurations.lisa
    ppuscasu.nix        — flake.homeConfigurations.ppuscasu (WSL)
system/
  <hostname>.nix        — NixOS module for that machine (imports hardware + helpers)
  helper/               — shared NixOS modules (fonts, pipewire, hyprland, sddm, security, etc.)
  <hostname>/           — hardware-configuration.nix + machine-specific extras (e.g. boot.nix)
user/
  home.nix              — main Home Manager config for wally (imports shell, dev-tools, theme, apps, hyprland)
  theme.nix             — GTK/Qt/cursor theming driven by userSettings
  apps/                 — GUI app configs (terminals, brave, freetube, zathura, imv, dunst)
  cli/                  — shell (bash+fish), nvim (nixvim), starship, tmux, fzf, lf, tools, scripts, kubectl
  wayland/              — Hyprland window manager, foot terminal, fuzzel launcher, ashell, waybar
  wsl.nix               — WSL-specific home config for ppuscasu
  lisa.nix              — separate home config for user lisa
```

## Architecture Patterns

**Dendritic pattern**: `flake.nix` is a thin entry point. `import-tree` auto-imports everything under `modules/` as flake-parts modules. Each `modules/hosts/*.nix` and `modules/home/*.nix` file is self-contained and declares exactly one `nixosConfiguration` or `homeConfiguration`. `modules/settings.nix` defines `options.cfg.*` so any module can read shared settings via `config.cfg.*` without specialArgs threading at the flake level.

**Adding a new host**: Create `modules/hosts/<hostname>.nix` — define local `systemSettings` with the correct hostname, then set `flake.nixosConfigurations.<hostname>`. Also create `system/<hostname>.nix` for the NixOS module content. `import-tree` picks it up automatically.

**Per-host systemSettings**: Each `modules/hosts/*.nix` defines its own local `systemSettings` attrset with the correct `hostname`. This is passed via `specialArgs` into the NixOS module tree, where many modules use `if (systemSettings.hostname == "workstation") then ... else ...` for per-machine variance.

**Shared userSettings**: Defined once in `modules/settings.nix` as `config.cfg.userSettings`. Host and home modules read it as `config.cfg.userSettings` and forward it as `specialArgs`/`extraSpecialArgs` into the NixOS/HM module trees.

**Unfree packages**: Defined in `modules/settings.nix` as `config.cfg.allowedUnfreePackages`. Home modules forward it as `allowed-unfree-packages` into HM specialArgs; `user/apps/apps.nix` applies it via `nixpkgs.config.allowUnfreePredicate`. Add names here before referencing them in package lists.

**Color theming**: `nix-colors` is the source of truth. `user/home.nix` sets `colorScheme = nix-colors.colorSchemes.${userSettings.colorTheme}`. Hyprland and other modules reference palette values via `config.colorScheme.palette.baseXX`.

**Shell aliases**: Defined in `user/cli/shell.nix` and applied to both bash and fish. Work-specific aliases live in `user/cli/dev-tools.nix` (also applied to both shells).

**Scripts**: Custom shell scripts live under `user/cli/scripts/`, each as a `pkgs.writeShellScriptBin` derivation imported via `user/cli/scripts/helper.nix`.

**Hyprland keybinds use submaps** (chords): `SUPER+B` opens a browsers submap, `SUPER+E` opens editors, `SUPER+G` opens programs, etc. See `user/wayland/hyprland.nix` for the full map.

## Flake Inputs

| Input | Purpose |
|-------|---------|
| `flake-parts` | Flake module system (entry point framework) |
| `import-tree` | Auto-imports all `.nix` files under `./modules/` as flake-parts modules |
| `nixpkgs` | nixos-unstable channel |
| `home-manager` | Home Manager (follows nixpkgs) |
| `nix-colors` | Color scheme library (catppuccin-mocha default) |
| `hyprland` | Hyprland WM flake (pins exact version) |
| `hyprland-plugins` | Optional Hyprland plugins (follows hyprland) |
| `nixvim` | Neovim configured via Nix |
| `nix-flatpak` | Declarative Flatpak management |

## Notes

- `flake.lock` is gitignored — inputs are re-locked on each `nix flake update`.
- `home.stateVersion = "23.11"` and `system.stateVersion = "23.05"` — do not change these.
- The `NH_FLAKE` session variable points to `~/.config/nixos`, so `nh` commands auto-discover this flake.
- Hyprland is installed from the flake input (not nixpkgs), so `package = null` in the Home Manager module to avoid conflicts.
