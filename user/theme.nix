{ config, pkgs, userSettings, systemSettings, ... }:

let
  pointer_size = if ( systemSettings.hostname == "minipc" ) then 42 else 18;
in
{
  # List of Themes

  # Gtk Config
  gtk = {
    enable = true;
    theme = {
      name = userSettings.theme;
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        accents = [ "blue" ];
      };
    };
    gtk4.theme = config.gtk.theme;
    iconTheme = {
      name = userSettings.iconTheme;
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
    platformTheme.name = "gtk3";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  # Mouse Pointer Configs
  home.pointerCursor = {
    enable = true;
    x11.enable = true;
    gtk.enable = true;
    hyprcursor = {
      enable = true;
    };
    name = userSettings.cursorTheme;
    package = pkgs.catppuccin-cursors.mochaDark;
    size = pointer_size;
  };
}
