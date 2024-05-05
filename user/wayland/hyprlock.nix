{ config, pkgs, userSettings, ... }:

{
  # Macchina Configs
  home.file = {
    "hyprlock.conf" = {
      enable = true;
      target = ".config/hypr/hyprlock.conf";
      text = "$font = Firacodenerdfont:Semibold
# GENERAL
general {
    disable_loading_bar = false
    hide_cursor = true
}

# BACKGROUND
background {
    monitor =
    path = /home/wally/Pictures/wallpapers/nix.png # path to PNG background
    blur_passes = 0
    color = rgb(${config.colorScheme.palette.base00})
}

# TIME
label {
    monitor =
    text = cmd[update:30000] echo $(date +'%R')
    color = rgb(${config.colorScheme.palette.base0D})
    font_size = 90
    font_family = $font
    position = -30, 0
    halign = right
    valign = top
}

# DATE 
label {
    monitor = 
    text = cmd[update:43200000] echo $(date +'%A,%e %B %Y')
    color = rgb(${config.colorScheme.palette.base05})
    font_size = 25
    font_family = $font
    position = -30, -150
    halign = right
    valign = top
}

# USER
label {
    monitor =
    text = Logging in as $USER
    color = rgb(${config.colorScheme.palette.base0C})
    font_size = 30
    font_family = $font
    position = 0, -280
    halign = center
    valign = center
}

# INPUT FIELD
input-field {
    monitor =
    size = 250, 40
    outline_thickness = 2
    dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
    dots_spacing = 0.2 # Scale of dots' absolute size, 0.0 - 1.0
    dots_center = true
    outer_color = rgb(${config.colorScheme.palette.base0D})
    inner_color = rgb(${config.colorScheme.palette.base0D})
    font_color = rgb(${config.colorScheme.palette.base00})
    fade_on_empty = false
    placeholder_text = <i><span foreground='##${config.colorScheme.palette.base00}'>Input Password...</span></i>
    hide_input = false
    position = 0, -350
    halign = center
    valign = center
}
      ";
    };
  };
}

