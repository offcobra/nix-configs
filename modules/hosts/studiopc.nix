# Host: studiopc -- GNOME workstation, shared with user lisa. systemd-boot.
{ inputs, config, ... }:
let
  c = config.constants;
  system = "x86_64-linux";
  userSettings = {
    inherit (c) username name email theme colorTheme iconTheme cursorTheme font;
    inherit system;
  };
  systemSettings = {
    hostname = "studiopc";
    inherit system;
    inherit (c) timezone locale;
    kernel = "linuxPackages_latest";
  };
in
{
  flake.modules.nixos.studiopc =
    { pkgs, ... }:
    {
      imports = [ ./_hw/studiopc.nix ];

      system.stateVersion = "25.11"; # machine identity — do not change

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.kernelPackages = pkgs.linuxPackages_latest;

      networking.hostName = "studiopc";
      services.openssh.enable = true;

      environment.variables = {
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_MUSIC_HOME = "$HOME/Music";
        XDG_CONFIG_HOME = "$HOME/.config";
      };

      # Second user on this machine.
      users.users.lisa = {
        isNormalUser = true;
        createHome = true;
        extraGroups = [ "wheel" "audio" "networkmanager" "storage" ];
        packages = with pkgs; [ tree ];
      };
    };

  flake.nixosConfigurations.studiopc = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      { nixpkgs.hostPlatform = system; }
    ]
    ++ (with config.flake.modules.nixos; [
      base
      wally
      studiopc
      gnome
      pipewire
      flatpak
    ]);
  };

  flake.homeConfigurations."wally@studiopc" =
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
      ];
    };
}
