{

  description = "OffTheWall's System Definitions";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    nixvim.url = "github:nix-community/nixvim";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = { nixpkgs, home-manager, nix-colors, nixvim, nix-flatpak, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      # ---- SYSTEM SETTINGS ---- #
      systemSettings = {
        system = "x86_64-linux"; # system arch
        hostname = "workstation"; # hostname
        timezone = "Europe/Berlin"; # select timezone
        locale = "en_US.UTF-8"; # select locale
        #kernel = "linuxPackages_zen"; # desired Kernel
        kernel = "linuxPackages_latest"; # desired Kernel
      };
      # ----- USER SETTINGS ----- #
      userSettings = rec {
        username = "wally"; # username
        name = "Wally Workstation"; # name/identifier
        email = "offthewall211@proton.me"; # email (used for certain configurations ex: git)
        dotfilesDir = "~/.dotfiles"; # absolute path of the local repo
        theme = "Dracula"; # selcted gtk theme
        colorTheme = "catppuccin-mocha"; # selcted theme from nix-colors
        iconTheme = "kora"; # selcted icontheme
        cursorTheme = "Dracula-cursors"; # selcted cursor-theme
        font = "FiraCodeNerdFont"; # selcted font
        wm = "hyprland"; # Selected window manager or desktop environment; must select one in both ./user/wm/ and ./system/wm/
      };
      allowed-unfree-packages = [
        "claude-code"
        "openclaw"
        "boundary"
        "vault-bin"
        "terraform"
        "spotify"
        "obsidian"
        "exodus"
      ];


    in {
      nixosConfigurations = import ./system/systems.nix {
        lib = lib;
        system = system;
        nix-flatpak = nix-flatpak;
        inputs = inputs;
        userSettings = userSettings;
        systemSettings = systemSettings;
      };
      homeConfigurations = import ./user/users.nix {
        pkgs = pkgs;
        inputs = inputs;
        nixvim = nixvim;
        home-manager = home-manager;
        nix-colors = nix-colors;
        userSettings = userSettings;
        systemSettings = systemSettings;
        allowed-unfree-packages = allowed-unfree-packages;
    };
  };
}
