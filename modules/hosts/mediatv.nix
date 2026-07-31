# Host: mediatv -- headless-ish media box. tty autologin, no WM, Flatpak apps.
{ inputs, config, ... }:
let
  c = config.constants;
  system = "x86_64-linux";
  userSettings = {
    inherit (c) username name email theme colorTheme iconTheme cursorTheme font;
    inherit system;
  };
  systemSettings = {
    hostname = "mediatv";
    inherit system;
    inherit (c) timezone locale;
    kernel = "linuxPackages_5_15";
  };
in
{
  flake.modules.nixos.mediatv = {
    imports = [ ./_hw/mediatv.nix ];

    networking.hostName = "mediatv";

    services.getty.autologinUser = c.username;
    services.openssh.enable = true;
    services.dbus.enable = true;
    programs.gnupg.agent.enable = true;

    powerManagement = {
      enable = true;
      cpuFreqGovernor = "performance";
    };
  };

  flake.nixosConfigurations.mediatv = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      { nixpkgs.hostPlatform = system; }
    ]
    ++ (with config.flake.modules.nixos; [
      base
      wally
      mediatv
      fonts
      pipewire
      flatpak
      polkit
      virtualization
    ]);
  };

  flake.homeConfigurations."wally@mediatv" =
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      extraSpecialArgs = {
        inherit inputs userSettings systemSettings;
        nixvim = inputs.nixvim;
        nix-colors = inputs.nix-colors;
        allowed-unfree-packages = c.allowedUnfreePackages;
      };
      modules = with config.flake.modules.homeManager; [
        base
        wally
        colors
        homeCore
        cli
      ];
    };
}
