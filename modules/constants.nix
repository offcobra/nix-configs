# Global constants shared across aspects.
#
# This is the ONE idea worth keeping from the old userSettings/systemSettings
# threading: define shared values once, read them anywhere as
# `config.constants.*` inside any flake-parts module. No specialArgs plumbing.
#
# Only genuinely GLOBAL values live here. Per-host values (hostname, kernel)
# belong in that host's composition file — they are not shared, so making them
# global would just invite `if hostname == ...` branching back in.
#
# To use a constant *inside* a nixos/homeManager aspect body, capture it in the
# outer flake-parts closure first:
#
#   { config, ... }:
#   let c = config.constants; in
#   { flake.modules.nixos.foo = { users.users.${c.username} = { ... }; }; }
{ lib, ... }:
{
  options.constants = lib.mkOption {
    type = lib.types.attrsOf lib.types.anything;
    description = "Global constants shared across all aspects.";
  };

  config.constants = {
    username = "wally";
    name = "Wally Workstation";
    email = "offthewall211@proton.me";

    timezone = "Europe/Berlin";
    locale = "en_US.UTF-8";

    # Theming (consumed by the theme + color aspects)
    theme = "Adwaita-dark"; # ships in gnome-themes-extra
    colorTheme = "catppuccin-mocha"; # key into nix-colors.colorSchemes
    iconTheme = "kora";
    cursorTheme = "Bibata-Modern-Classic"; # ships in bibata-cursors
    font = "FiraCodeNerdFont";

    allowedUnfreePackages = [
      "claude-code"
      "openclaw"
      "boundary"
      "vault-bin"
      "terraform"
      "spotify"
      "obsidian"
      "exodus"
    ];
  };
}
