{ config, pkgs, nixvim, nix-colors, userSettings, systemSettings, ... }:

{
  imports =
    [ # Include other modules
      nix-colors.homeManagerModules.default
      # Import Nixvim
      nixvim.homeModules.nixvim
      # Window Manager
      ./wayland/hyprland.nix
      ./cli/shell.nix
      ./cli/dev-tools.nix
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

  # Sessionvariables
  home.sessionVariables = {
        EDITOR = "nvim";
        NIXOS_OZONE_WL = "1";
        XKB_DEFAULT_LAYOUT = "de";
        VISUAL = "nvim";
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
