{

  description = "OffTheWall's System Definitions";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let 
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      workstation = lib.nixosSystem {
        inherit system;
        modules = [ ./system/system.nix ];
      };
      thinkpad = lib.nixosSystem {
        inherit system;
        modules = [ ./system/thinkpad.nix ];
      };
    };
    homeConfigurations = {
      wally = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./user/home.nix ];
        extraSpecialArgs = {
        };
      };
    };
  };

}
