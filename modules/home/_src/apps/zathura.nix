{ config, ... }:

{
  # Zathura PDF Config
  programs.zathura = {
    enable = true;
    options = {
      default-bg = "#${config.colorScheme.palette.base00}";
      default-fg = "#${config.colorScheme.palette.base05}";
    };
  };
}
