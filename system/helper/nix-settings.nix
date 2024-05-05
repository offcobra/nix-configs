{ config, pkgs, ... }:

{
  # Nix Settings

  # Dont Change...
  system.stateVersion = "23.05"; # Did you read the comment?
  
  nix = {
    settings = {
      warn-dirty = true;
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
