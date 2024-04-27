{ config, pkgs, userSettings, ... }:

# Theme packages
#nwg-look
#dracula-theme
#catppuccin
#gruvbox-gtk-theme
#gruvbox-dark-icons-gtk
#gnome.adwaita-icon-theme
#numix-cursor-theme
#material-cursors
#beauty-line-icon-theme
#candy-icons
# Themes done

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
    size = 20;
  };
}

