{ config, pkgs, systemSettings, userSettings, ... }:

let
  font_size = if (systemSettings.hostname == "workstation") then "12" else "8";
in
{
  # Fuzzel App Launcher
  programs.fuzzel = {
    enable = true;
    package = pkgs.fuzzel;
    settings = {
      main = {
        font = "${userSettings.font}:Semibold:size=${font_size}";
        line-height = if (systemSettings.hostname == "workstation") then 16 else 12;
        width = 40;
        lines = 10;
        icons-enabled = "yes";
      };
      colors = {
        background = "${config.colorScheme.palette.base00}dd";
        text = "${config.colorScheme.palette.base05}ff";
        match = "${config.colorScheme.palette.base08}ff";
        selection-match = "${config.colorScheme.palette.base00}ff";
        selection = "${config.colorScheme.palette.base0D}dd";
        selection-text = "${config.colorScheme.palette.base00}ff";
        border = "${config.colorScheme.palette.base0E}ee";
      };
    };
  };
}
