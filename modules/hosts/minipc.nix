# Host: minipc -- Hyprland desktop box (steam, no VFIO). systemd-boot.
{ inputs, config, ... }:
let
  c = config.constants;
  system = "x86_64-linux";
  userSettings = {
    inherit (c) username name email theme colorTheme iconTheme cursorTheme font;
    inherit system;
  };
  systemSettings = {
    hostname = "minipc";
    inherit system;
    inherit (c) timezone locale;
    kernel = "linuxPackages_latest";
  };
in
{
  flake.modules.nixos.minipc =
    { pkgs, ... }:
    {
      imports = [ ./_hw/minipc.nix ];

      system.stateVersion = "25.11"; # machine identity — do not change

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.kernelPackages = pkgs.linuxPackages_latest;

      networking.hostName = "minipc";
      networking.firewall.allowedTCPPorts = [ 22 ];

      services.openssh.enable = true;
    };

  flake.nixosConfigurations.minipc = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      { nixpkgs.hostPlatform = system; }
    ]
    ++ (with config.flake.modules.nixos; [
      base
      wally
      minipc
      hyprland
      sddm
      fonts
      thunar
      steam
      pipewire
      flatpak
      polkit
      security
    ]);
  };

  flake.homeConfigurations."wally@minipc" =
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
        theme
        apps
        wayland
        hyprland
      ];
    };
}
