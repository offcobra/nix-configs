{ config, pkgs, userSettings, ... }:

{
  # Macchina Configs
  home.file = {
    "hyprpaper.conf" = {
      enable = true;
      target = ".config/hypr/hyprpaper.conf";
      text = "preload = ~/.config/nixos/user/wallpapers/rainforest.jpg
preload = ~/.config/nixos/user/wallpapers/neversettle.jpg
preload = ~/.config/nixos/user/wallpapers/opensource.jpg
wallpaper = DP-1,~/.config/nixos/user/wallpapers/rainforest.jpg
wallpaper = DP-2,~/.config/nixos/user/wallpapers/neversettle.jpg
wallpaper = DP-3,~/.config/nixos/user/wallpapers/opensource.jpg";
    };
  };
}
