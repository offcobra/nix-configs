{ config, pkgs, userSettings, ... }:

{
  # Hypridle Configs
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

#listener {
#    timeout = 600                               # 10 min
#    on-timeout = screen_chill                   # screen_chill
#    on-resume = screen_full                     # screen_full
#}
#
#listener {
#    timeout = 1200                              # 20 min
#    on-timeout = screen_work                    # screen_work
#    on-resume = screen_full                     # screen_full
#}

listener {
    timeout = 1800                              # 30 min
    on-timeout = poweroff                       # poweroff
}
      ";
    };
  };
}

