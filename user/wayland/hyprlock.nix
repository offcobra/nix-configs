{ config, userSettings, ... }:

let
  font = "Firacodenerdfont:Semibold";
in
{
  # Hyprlock Configs
  programs.hyprlock = {
    enable = true;
    settings= {
      general = {
        disable_loading_bar = true;
        grace = 60;
        hide_cursor = true;
        no_fade_in = false;
      };
      background = [{
        monitor = "";
        blur_passes = 3;
        blur_size = 2;
        color = "rgb(${config.colorScheme.palette.base00})";
        path = "/home/${userSettings.username}/.config/nixos/user/wallpapers/nix.png"; # path to PNG background
      }];
      label = [{
        monitor = "";
        text = "cmd[update:30000] echo $(date +'%R')";
        color = "rgb(${config.colorScheme.palette.base0D})";
        font_size = 70;
        font_family = font;
        position = "-30, 0";
        halign = "right";
        valign = "top";
      } {
        monitor = "";
        text = "cmd[update:43200000] echo $(date +'%A,%e %B %Y')";
        color = "rgb(${config.colorScheme.palette.base05})";
        font_size = 20;
        font_family = font;
        position = "-30, -100";
        halign = "right";
        valign = "top";
      } {
        monitor = "";
        text = "Logging in as $USER";
        color = "rgb(${config.colorScheme.palette.base0C})";
        font_size = 20;
        font_family = font;
        position = "0, -280";
        halign = "center";
        valign = "center";
      }];
      input-field = [{
        monitor = "";
        size = "250, 40";
        outline_thickness = 2;
        dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        outer_color = "rgb(${config.colorScheme.palette.base0D})";
        inner_color = "rgb(${config.colorScheme.palette.base0D})";
        font_color = "rgb(${config.colorScheme.palette.base00})";
        fade_on_empty = false;
        placeholder_text = "<i><span foreground='##${config.colorScheme.palette.base00}'>Input Password...</span></i>";
        hide_input = false;
        position = "0, -350";
        halign = "center";
        valign = "center";
      }];
    };
  };
}
