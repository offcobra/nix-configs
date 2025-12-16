{ pkgs, home-manager, inputs, nixvim, nix-colors, userSettings, systemSettings, allowed-unfree-packages, ... }:

{
  wally = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    modules = [
      # Hyprland flake
      inputs.hyprland.homeManagerModules.default

      # Wally Home configurations
      ./home.nix
    ];
    extraSpecialArgs = {
      inherit inputs;
      inherit nixvim;
      inherit nix-colors;
      inherit userSettings;
      inherit systemSettings;
      inherit allowed-unfree-packages;
    };
  };

  lisa = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    modules = [ ./lisa.nix ];
    extraSpecialArgs = {
      inherit inputs;
      inherit userSettings;
      inherit systemSettings;
    };
  };

  ppuscasu = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    modules = [ ./wsl.nix ];
    extraSpecialArgs = {
      inherit inputs;
      inherit nixvim;
      inherit nix-colors;
      inherit userSettings;
      inherit systemSettings;
      inherit allowed-unfree-packages;
    };
  };
}
