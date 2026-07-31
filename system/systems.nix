{ lib, system, hermes-agent, nix-flatpak, inputs, userSettings, systemSettings, ... }:

{
  workstation = lib.nixosSystem {
    inherit system;
    modules = [
      # Flatpaks
      nix-flatpak.nixosModules.nix-flatpak
      hermes-agent.nixosModules.default

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
    modules = [
      nix-flatpak.nixosModules.nix-flatpak
      ./mediatv.nix
    ];
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
