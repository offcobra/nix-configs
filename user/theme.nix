{ pkgs, userSettings, systemSettings, ... }:

let
  pointer_size = if ( systemSettings.hostname == "mediatv" ) then 20 else 10;
in
{
  # List of Themes

  # Gtk Config
  gtk = {
    enable = true;
    theme = {
      name = userSettings.theme;
      package = pkgs.dracula-theme;
      #package = pkgs.nordic;
    };
    iconTheme = {
      name = userSettings.iconTheme;
      #package = pkgs.candy-icons;
      package = pkgs.kora-icon-theme;
    };
    font = {
      name = userSettings.font;
      size = 9;
      package = pkgs.nerd-fonts.fira-code;
    };
  };

  # Qt Configs
  qt = {
    enable = true;
    platformTheme.name = "gtk";
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
    size = pointer_size;
  };
}
