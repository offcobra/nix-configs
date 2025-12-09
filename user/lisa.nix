{ pkgs, userSettings, ... }:

{
  imports =
    [ # Include other modules
      # Applications
      ./apps/brave.nix
    ];


  # Home Manager
  home.username = "lisa";
  home.homeDirectory = "/home/lisa";
  home.stateVersion = "23.11"; # Please dont change

  # environment packages.
  home.packages = with pkgs; [
    libreoffice-fresh
    thunderbird-bin
    dconf
  ];

  # Gtk Config
  gtk = {
    enable = true;
    theme = {
      name = "WhiteSur-Dark-solid";
      package = pkgs.whitesur-gtk-theme;
      #package = pkgs.nordic;
    };
    iconTheme = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-icon-theme;
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
    name = "WhiteSur";
    package = pkgs.whitesur-cursors;
    size = 10;
  };

  # Sessionvariables
  home.sessionVariables = {
      EDITOR = "nvim";
      NIXOS_OZONE_WL = "1";
      XKB_DEFAULT_LAYOUT = "de";
      VISUAL = "vim";
      PAGER = "bat --pager 'less'";
      LIBVIRT_DEFAULT_URI = "qemu:///system";
      NH_FLAKE = "/home/${userSettings.username}/.config/nixos";
      SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS = "0";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      HYPRSHOT_DIR = "/home/${userSettings.username}/Pictures/Screenshots";
      _ZO_DOCTOR="0";
  };

  # SessionPath
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
  };
}
