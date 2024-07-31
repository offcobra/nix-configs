{ systemSettings, ... }:

{
  # Macchina Configs
  home.file = {
    "hyprpaper.conf" = {
      enable = true;
      target = ".config/hypr/hyprpaper.conf";
      text = if (systemSettings.hostname == "workstation")
        then
"preload = ~/.config/nixos/user/wallpapers/rainforest.jpg
preload = ~/.config/nixos/user/wallpapers/neversettle.jpg
preload = ~/.config/nixos/user/wallpapers/opensource.jpg
wallpaper = DP-1,~/.config/nixos/user/wallpapers/rainforest.jpg
wallpaper = DP-2,~/.config/nixos/user/wallpapers/neversettle.jpg
wallpaper = DP-3,~/.config/nixos/user/wallpapers/opensource.jpg"
        else if (systemSettings.hostname == "thinkpad")
        then
"preload = ~/.config/nixos/user/wallpapers/rainforest.jpg
wallpaper = eDP-1,~/.config/nixos/user/wallpapers/rainforest.jpg"
        else
"preload = ~/.config/nixos/user/wallpapers/rainforest.jpg
wallpaper = HDMI-A-1,~/.config/nixos/user/wallpapers/rainforest.jpg";
    };
  };
}
