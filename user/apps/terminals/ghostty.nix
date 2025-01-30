{ config, pkgs, userSettings, ... }:

{
  # Ghosty Terminal
  config.programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    themes = {
      custom = {
        background = "#${config.colorScheme.palette.base00}";
        cursor-color = "#${config.colorScheme.palette.base06}";
        foreground = "#${config.colorScheme.palette.base05}";
        palette = [
          "0=#${config.colorScheme.palette.base04}"
          "1=#${config.colorScheme.palette.base06}"
          "2=#${config.colorScheme.palette.base0B}"
          "3=#${config.colorScheme.palette.base09}"
          "4=#${config.colorScheme.palette.base0D}"
          "5=#${config.colorScheme.palette.base0C}"
          "6=#${config.colorScheme.palette.base0E}"
          "7=#${config.colorScheme.palette.base05}"
        ];
        selection-background = "#${config.colorScheme.palette.base06}";
        selection-foreground = "#${config.colorScheme.palette.base01}";
      };
    };
    settings = {
      theme = "custom";

      window-padding-x = 12;
      window-padding-y = 8;

      confirm-close-surface = false;

      font-size = 8.5;
      font-family = "FiraCode Nerd Font SemBd";
      font-family-bold = "FiraCode Nerd Font Bold";

      window-decoration = false;
    };
  };
}
