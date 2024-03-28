{ config, pkgs, ... }:

{
  # List of Themes
  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
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
      name = "BeautyLine";
      package = pkgs.beauty-line-icon-theme;
    };
    font = {
      name = "FireCode";
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
    name = "Dracula-cursors";
    package = pkgs.dracula-theme;
    size = 20;
  };
}

