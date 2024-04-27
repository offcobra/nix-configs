{ config, pkgs, userSettings, ... }:

{
  # Macchina Configs
  home.file = {
    "hyprpaper.conf" = {
      enable = true;
      target = ".config/hypr/hyprpaper.conf";
      text = "preload = ~/Pictures/wallpapers/0260.jpg
preload = ~/Pictures/wallpapers/0200.jpg
preload = ~/Pictures/wallpapers/0180.jpg
wallpaper = DP-1,~/Pictures/wallpapers/0260.jpg
wallpaper = DP-3,~/Pictures/wallpapers/0200.jpg
wallpaper = DP-2,~/Pictures/wallpapers/0180.jpg";
    };
  };
}

