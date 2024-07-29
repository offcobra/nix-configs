{ config, ... }:

{
  # Alacritty Terminal
  config.programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      window.padding = {
        x = 12;
        y = 8;
      };
      scrolling = {
        history = 5000;
      };
      cursor = {
        unfocused_hollow = true;
        style = "Block";
      };
      font = {
        size = 8;
        normal = {
          family = "Firacodenerdfont";
          style = "Semibold";
        };
        bold = {
          family = "FiraCodeNerdFont";
          style = "Bold";
        };
        italic = {
          family = "FiraCodeNerdFont";
          style = "Italic";
        };
        bold_italic = {
          family = "FiraCodeNerdFont";
          style = "Bold Italic";
        };
      };
      colors = {
        primary = {
          background = "#${config.colorScheme.palette.base00}";
          foreground = "#${config.colorScheme.palette.base05}";
          dim_foreground = "#${config.colorScheme.palette.base01}";
          bright_foreground = "#${config.colorScheme.palette.base06}";
        };
        cursor = {
          text = "#${config.colorScheme.palette.base02}";
          cursor = "#${config.colorScheme.palette.base06}";
        };
        normal = {
          black = "#${config.colorScheme.palette.base04}";
          red = "#${config.colorScheme.palette.base06}";
          green = "#${config.colorScheme.palette.base0B}";
          yellow = "#${config.colorScheme.palette.base09}";
          blue = "#${config.colorScheme.palette.base0D}";
          magenta = "#${config.colorScheme.palette.base0C}";
          cyan = "#${config.colorScheme.palette.base0E}";
          white = "#${config.colorScheme.palette.base05}";
        };
      };
    };
  };
}

