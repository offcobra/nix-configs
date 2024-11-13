{ systemSettings, ... }:

let
  timer = if (systemSettings.hostname == "workstation")
          # On Workstation PC...
          then
            [{
              timeout = 300;                                 # 5 min
              on-timeout = "loginctl lock-session";          # lock screen
            } {
              timeout = 600;                                 # 10 min
              on-timeout = "screen-chill.sh";                # screen-chill script (2screens)
              on-resume = "screen-full.sh";                  # screen-full
            } {
              timeout = 1200;                                # 20 min
              on-timeout = "screen-work.sh";                 # screen-work script (1screens)
              on-resume = "screen-full.sh";                  # screen-full
            } {
              timeout = 1800;                                # 30 min
              on-timeout = "poweroff";                       # poweroff
            }]
          # Everywhere else...
          else
            [{
              timeout = 300;                                 # 5 min
              on-timeout = "loginctl lock-session";          # lock screen
            } {
              timeout = 1800;                                # 30 min
              on-timeout = "poweroff";                       # poweroff
            }];
in
{
  # Hypridle Configs
  services.hypridle = {
    enable = true;
    settings= {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";       # launch hyprlock
        before_sleep_cmd = "loginctl lock-session";    # lock before suspend.
        after_sleep_cmd = "hyprctl dispatch dpms on";  # to avoid having to press a key twice to turn on the display.
      };
      listener = timer;
    };
  };
}
