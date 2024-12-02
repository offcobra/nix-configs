{ config, ... }:

{
  programs.urxvt = {
    enable = true;
    fonts = [
      "xft:Fira Code:size:7"
    ];
    extraConfig = {
      background = "#${config.colorScheme.palette.base00}";
      foreground = "#${config.colorScheme.palette.base05}";
      cursor = "#${config.colorScheme.palette.base06}";


      # Black
      color0 = "#${config.colorScheme.palette.base04}";
      color8 = "#${config.colorScheme.palette.base04}";

      # Red
      color1 = "#${config.colorScheme.palette.base06}";
      color9 = "#${config.colorScheme.palette.base06}";

      # Green
      color2 = "#${config.colorScheme.palette.base0B}";
      color10 = "#${config.colorScheme.palette.base0B}";

      # Yellow
      color3 = "#${config.colorScheme.palette.base09}";
      color11 = "#${config.colorScheme.palette.base09}";

      # Blue
      color4 = "#${config.colorScheme.palette.base0D}";
      color12 = "#${config.colorScheme.palette.base0D}";

      # Magenta
      color5 = "#${config.colorScheme.palette.base0C}";
      color13 = "#${config.colorScheme.palette.base0C}";

      # Cyan
      color6 = "#${config.colorScheme.palette.base0E}";
      color14 = "#${config.colorScheme.palette.base0E}";

      # White
      color7 = "#${config.colorScheme.palette.base05}";
      color15 = "#${config.colorScheme.palette.base05}";
    };
  };
}
