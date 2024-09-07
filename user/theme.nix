{ pkgs, userSettings, ... }:

{
  # List of Themes

  # Gtk Config
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

  # Qt Configs
  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  # Mouse Pointer Configs
  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    name = userSettings.cursorTheme;
    package = pkgs.dracula-theme;
    size = 10;
  };
}
