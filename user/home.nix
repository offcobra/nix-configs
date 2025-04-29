{ config, pkgs, nixvim, nix-colors, userSettings, systemSettings, ... }:

{
  imports =
    [ # Include other modules
      nix-colors.homeManagerModules.default
      # Import Nixvim
      nixvim.homeManagerModules.nixvim
      # Window Manager
      ./wayland/hyprland.nix
      ./x11/qtile.nix
      # Bash Config
      ./cli/shell.nix
      # Gtk Themes
      ./theme.nix
      # Applications
      ./apps/apps.nix
    ];

  colorScheme = nix-colors.colorSchemes.${userSettings.colorTheme};

  # Home Manager
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;
  home.stateVersion = "23.11"; # Please dont change

  # environment packages.
  home.packages = with pkgs; [
    dconf
  ];

  # XDG Files to be linked
  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  # Linking Home Files
  home.file = {
    ".icons/BeautyLine".source = "${pkgs.beauty-line-icon-theme}/share/icons/BeautyLine";
    ".themes/Catppuccin-Frappe-Standard-Blue-Dark".source = "${pkgs.catppuccin-gtk}/share/themes/Catppuccin-Frappe-Standard-Blue-Dark";
    ".themes/Dracula".source = "${pkgs.dracula-theme}/share/themes/Dracula";
    #".local/share/fonts".source = "${pkgs.nerd-fonts.fira-code}/share/fonts/truetype/NerdFonts";
  };

  # Sessionvariables
  home.sessionVariables = if (systemSettings.hostname == "mediatv")
    then
      {
        EDITOR = "nvim";
        NIXOS_OZONE_WL = "0";
        XKB_DEFAULT_LAYOUT = "de";
        VISUAL = "vim";
        PAGER = "bat --pager 'less'";
        NH_FLAKE = "/home/${userSettings.username}/.config/nixos";
        SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS = "0";
        ELECTRON_OZONE_PLATFORM_HINT = "x11";
        LIBVA_DRIVER_NAME = "nvidia";
        XDG_SESSION_TYPE = "x11";
        GBM_BACKEND = "nvidia-drm";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        AQ_DRM_DEVICES = "/dev/dri/card0:/dev/dri/card1";
      }
    else
      {
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
