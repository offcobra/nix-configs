{ systemSettings, ... }:

{
  # Configuring Hyprpaper Wallpapers
  services.hyprpaper.enable = true;

  # Temporary fix for hyprpaper...
  # TODO: Fix me
  home.file.".config/hypr/hyprpaper.conf".text = ''
wallpaper {
    monitor = DP-1
    path = ~/.config/nixos/user/wallpapers/opensource.jpg
    fit_mode = cover
}

wallpaper {
    monitor = HDMI-A-1
    path = ~/.config/nixos/user/wallpapers/railjard.jpg
    fit_mode = cover
}

wallpaper {
    monitor =
    path = ~/.config/nixos/user/wallpapers/neversettle.jpg
    fit_mode = cover
}
  '';
}
