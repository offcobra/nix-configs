{ config, pkgs, userSettings, ... }:

{
  # Macchina Configs
  home.file = {
    "macchina.toml" = {
      enable = true;
      target = ".config/macchina/macchina.toml";
      source = ./macchina.toml;
    };
    "wally.toml" = {
      enable = true;
      target = ".config/macchina/themes/wally.toml";
      source = ./wally.toml;
    };
    "nix.txt" = {
      enable = true;
      target = ".config/macchina/themes/nix.txt";
      source = ./nix.txt;
    };
  };
}

