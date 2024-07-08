{ config, pkgs, userSettings, ... }:

{
  # List of Themes
  gtk = {
    enable = true;
    theme = {
      name = userSettings.theme;
      package = pkgs.dracula-theme;
      #name = "Catppuccin-Macchiato-Compact-Blue-Dark";
      #package = pkgs.catppuccin-gtk.override {
      #  accents = [ "yellow" ];
      #  size = "compact";
      #  tweaks = [ "rimless" ];
      #  variant = "macchiato";
      #};
    };
    iconTheme = {
      name = userSettings.iconTheme;
      package = pkgs.beauty-line-icon-theme;
    };
    font = {
      name = userSettings.font; 
      package = pkgs.fira-code-nerdfont;
    };
    #cursorTheme = {
    #  name = "Dracula-cursors";
    #  package = pkgs.dracula-theme;
    #};
  };
  
  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    name = userSettings.cursorTheme;
    package = pkgs.dracula-theme;
    size = 14;
  };
}

