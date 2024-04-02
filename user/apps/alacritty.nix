{ config, pkgs, ... }:

{
  # Alacritty Terminal
  programs.alacritty = {
    enable = true;
    settings = {
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
          background = "#24273A";
          foreground = "#CAD3F5";
          dim_foreground = "#CAD3F5";
          bright_foreground = "#CAD3F5";
        };
        cursor = {
          text = "#24273A";
          cursor = "#F4DBD6";
        };
        normal = {
          black = "#494D64";
          red = "#ED8796";
          green = "#A6DA95";
          yellow = "#EED49F";
          blue = "#8AADF4";
          magenta = "#F5BDE6";
          cyan = "#8BD5CA";
          white = "#B8C0E0";
        };
        bright = {
          black = "#5B6078";
          red = "#ED8796";
          green = "#A6DA95";
          yellow = "#EED49F";
          blue = "#8AADF4";
          magenta = "#F5BDE6";
          cyan = "#8BD5CA";
          white = "#A5ADCB";
        };
      };
    };
  };
}

