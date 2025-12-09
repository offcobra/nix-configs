{ lib, system, nix-flatpak, chaotic, inputs, userSettings, systemSettings, ... }:

{
  workstation = lib.nixosSystem {
    inherit system;
    modules = [
      # Flatpaks
      nix-flatpak.nixosModules.nix-flatpak

      # chaotic bleeding-edge
      chaotic.nixosModules.default # IMPORTANT

      ./workstation.nix
    ];
    specialArgs = {
      inherit inputs;
      inherit userSettings;
      inherit systemSettings;
    };
  };

  thinkpad = lib.nixosSystem {
    inherit system;
    modules = [
      # Flatpaks
      nix-flatpak.nixosModules.nix-flatpak

      ./thinkpad.nix
    ];
    specialArgs = {
      inherit inputs;
      inherit userSettings;
      inherit systemSettings;
    };
  };

  mediatv = lib.nixosSystem {
    inherit system;
    modules = [ ./mediatv.nix ];
    specialArgs = {
      inherit inputs;
      inherit userSettings;
      inherit systemSettings;
    };
  };

  home-studio = lib.nixosSystem {
    inherit system;
    modules = [
      # Flatpaks
      nix-flatpak.nixosModules.nix-flatpak

      ./studiopc.nix
    ];
    specialArgs = {
      inherit inputs;
      inherit userSettings;
      inherit systemSettings;
    };
  };
}
