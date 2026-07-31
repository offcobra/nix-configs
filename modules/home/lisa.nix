# Home: lisa -- standalone homeConfiguration (used on studiopc).
# The leaf config lives in _src/lisa.nix and defines its own identity;
# userSettings is bridged from constants for the few paths it interpolates.
{ inputs, config, ... }:
let
  c = config.constants;
  system = "x86_64-linux";
  userSettings = {
    inherit (c) username name email theme colorTheme iconTheme cursorTheme font;
    inherit system;
  };
in
{
  flake.homeConfigurations.lisa =
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {
        inherit inputs userSettings;
      };
      modules = [ ./_src/lisa.nix ];
    };
}
