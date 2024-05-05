{ config, pkgs, userSettings, ... }:

{
  # Macchina Configs
  home.file = {
    "hypridle.conf" = {
      enable = true;
      target = ".config/hypr/hypridle.conf";
      text = "# OffTheWall's Hypridle Config
general {
    lock_cmd = pidof hyprlock || hyprlock       # launch hyprlock
    before_sleep_cmd = loginctl lock-session    # lock before suspend.
    after_sleep_cmd = hyprctl dispatch dpms on  # to avoid having to press a key twice to turn on the display.
}

listener {
    timeout = 300                               # 5 min
    on-timeout = loginctl lock-session          # lock screen
}
      ";
    };
  };
}

