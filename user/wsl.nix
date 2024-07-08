{ inputs, config, pkgs, nixvim, nix-colors, userSettings, ... }:

{
  imports =
    [ # Include other modules
      nix-colors.homeManagerModules.default
      # Import Nixvim
      nixvim.homeManagerModules.nixvim
      # Bash Config
      ./cli/bash.nix
      # Gtk Themes
      ./theme.nix
      # Alacritty Config
      ./apps/alacritty.nix
    ];
  colorScheme = nix-colors.colorSchemes.${userSettings.colorTheme};

  # Home Manager 
  home.username = "ppuscasu";
  home.homeDirectory = "/home/ppuscasu/";
  home.stateVersion = "24.05"; # Please dont change

  # environment.
  home.packages = with pkgs; [
    (pkgs.nerdfonts.override { fonts = [ "SourceCodePro" ]; })

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
    XKB_DEFAULT_LAYOUT = "de";
    VISUAL="vim";
    PAGER="bat --pager 'less'";
    FLAKE="/home/ppuscasu/.config/nixos";
    SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS="0";
    LC_ALL="C.UTF-8";
    LANG="C.UTF-8";
    LANGUAGE="en_US.UTF-8";
  };

  # SessionPath
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
  };
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
}


# A small Doc for the wsl install
# - install nerd fonts & alacritty
# - install openssh git nix 
# - clone dotfiles repo
# - nix install home-manager nix-command flakes
# - fix username conflics
# git config --local status.showUntrackedFiles no
