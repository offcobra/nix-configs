{ pkgs, userSettings, ... }:

{
  # List of Themes
  gtk = {
    enable = true;
    theme = {
      name = userSettings.theme;
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = userSettings.iconTheme;
      package = pkgs.beauty-line-icon-theme;
    };
    font = {
      name = userSettings.font;
      package = pkgs.fira-code-nerdfont;
    };
  };

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    name = userSettings.cursorTheme;
    package = pkgs.dracula-theme;
    size = 14;
  };
}
