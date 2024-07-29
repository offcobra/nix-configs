{ config, pkgs, nixvim, nix-colors, userSettings, ... }:

{
  imports =
    [ # Include other modules
      nix-colors.homeManagerModules.default
      # Import Nixvim
      nixvim.homeManagerModules.nixvim
      # Window Manager
      ./wayland/hyprland.nix
      # Bash Config
      ./cli/bash.nix
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

  # environment.
  home.packages = with pkgs; [
    dconf
    (nerdfonts.override { fonts = [ "SourceCodePro" ]; })

    # # ShellScript Example
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # XDG Files to be linked
  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  # Linking Home Files
  home.file = {
    ".icons/BeautyLine".source = "${pkgs.beauty-line-icon-theme}/share/icons/Beautyline";
    ".themes/Catppuccin-Frappe-Standard-Blue-Dark".source = "${pkgs.catppuccin-gtk}/share/themes/Catppuccin-Frappe-Standard-Blue-Dark";
    ".themes/Dracula".source = "${pkgs.dracula-theme}/share/themes/Dracula";
    ".local/share/fonts".source = "${pkgs.fira-code-nerdfont}/share/fonts/truetype/NerdFonts";

  };

  # Sessionvariables
  home.sessionVariables = {
    EDITOR="nvim";
    NIXOS_OZONE_WL = "1";    
    XKB_DEFAULT_LAYOUT = "de";
    VISUAL="vim";
    PAGER="bat --pager 'less'";
    LIBVIRT_DEFAULT_URI="qemu:///system";
    FLAKE="/home/wally/.config/nixos";
    SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS="0";
    ELECTRON_OZONE_PLATFORM_HINT="auto";
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
