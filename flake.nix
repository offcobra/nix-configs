{

  description = "OffTheWall's System Definitions";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    #home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, nix-colors, ... }@inputs:
    let 
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      
       # ---- SYSTEM SETTINGS ---- #
      systemSettings = {
        system = "x86_64-linux"; # system arch
        hostname = "workstation"; # hostname
        profile = "personal"; # select a profile defined from my profiles directory
        timezone = "Europe/Berlin"; # select timezone
        locale = "en_US.UTF-8"; # select locale
      };
      # ----- USER SETTINGS ----- #
      userSettings = rec {
        username = "wally"; # username
        name = "Wally Workstation"; # name/identifier
        email = "offthewall211@proton.me"; # email (used for certain configurations)
        dotfilesDir = "~/.dotfiles"; # absolute path of the local repo
        theme = "Dracula"; # selcted gtk theme 
        colorTheme = "catppuccin-mocha"; # selcted theme from nix-colors
        iconTheme = "BeautyLine"; # selcted icontheme 
        cursorTheme = "Dracula-cursors"; # selcted cursor-theme 
        font = "FireCodeNerdFont"; # selcted font
        wm = "hyprland"; # Selected window manager or desktop environment; must select one in both ./user/wm/ and ./system/wm/
        # window manager type (hyprland or x11) translator
        wmType = if (wm == "hyprland") then "wayland" else "x11";
      };

    in {
    nixosConfigurations = {
      workstation = lib.nixosSystem {
        inherit system;
        modules = [ ./system/workstation.nix ];
        specialArgs = {
          inherit inputs;
          inherit userSettings;
          inherit systemSettings;
        };
      };
      thinkpad = lib.nixosSystem {
        inherit system;
        modules = [ ./system/thinkpad.nix ];
        specialArgs = {
          inherit inputs;
          inherit userSettings;
          inherit systemSettings;
        };
      };
    };
    homeConfigurations = {
      wally = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./user/home.nix ];
        extraSpecialArgs = {
          inherit nix-colors;
          inherit userSettings;
          inherit systemSettings;
        };
      };
    };
  };

}
