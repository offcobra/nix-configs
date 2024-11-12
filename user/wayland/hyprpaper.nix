{ systemSettings, ... }:

let
  wallpaper = if (systemSettings.hostname == "workstation")
    then
    [
      "DP-1,~/.config/nixos/user/wallpapers/fantasy-landscape.png"
      "DP-2,~/.config/nixos/user/wallpapers/city-bridge.jpg"
      "DP-3,~/.config/nixos/user/wallpapers/midnight-sea.jpg"
    ]
    else if (systemSettings.hostname == "thinkpad")
    then
      ["eDP-1,~/.config/nixos/user/wallpapers/city-bridge.jpg"]
    else
      ["HDMI-A-1,~/.config/nixos/user/wallpapers/city-bridge.jpg"];
in
{
  # Configuring Hyprpaper Wallpapers
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [
        "~/.config/nixos/user/wallpapers/fantasy-landscape.png"
        "~/.config/nixos/user/wallpapers/city-bridge.jpg"
        "~/.config/nixos/user/wallpapers/midnight-sea.jpg"
      ];

      wallpaper = wallpaper;
    };
  };
}
