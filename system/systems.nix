{ lib, system, nix-flatpak, inputs, userSettings, systemSettings, ... }:

{
  workstation = lib.nixosSystem {
    inherit system;
    modules = [
      # Flatpaks
      nix-flatpak.nixosModules.nix-flatpak

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

  minipc = lib.nixosSystem {
    inherit system;
    modules = [
      # Flatpaks
      nix-flatpak.nixosModules.nix-flatpak

      ./minipc.nix
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

  studiopc = lib.nixosSystem {
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
