# Home: ppuscasu -- WSL homeConfiguration (work machine, no NixOS underneath).
# The leaf config lives in _src/wsl.nix. pkgs is deliberately a PLAIN
# legacyPackages instantiation (no allowUnfree = true) so the leaf's
# allowUnfreePredicate over constants.allowedUnfreePackages stays in charge —
# same behavior as the old users.nix.
{ inputs, config, ... }:
let
  c = config.constants;
  system = "x86_64-linux";
  userSettings = {
    inherit (c) username name email theme colorTheme iconTheme cursorTheme font;
    inherit system;
  };
  # Only consumed by nvim/keybindings.nix for a terminal-size default; any
  # non-"thinkpad" hostname yields the same value the old flake produced.
  systemSettings = {
    hostname = "wsl";
    inherit system;
    inherit (c) timezone locale;
  };
in
{
  flake.homeConfigurations.ppuscasu =
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {
        inherit inputs userSettings systemSettings;
        nixvim = inputs.nixvim;
        nix-colors = inputs.nix-colors;
        allowed-unfree-packages = c.allowedUnfreePackages;
      };
      modules = [ ./_src/wsl.nix ];
    };
}
