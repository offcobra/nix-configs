{ config, pkgs, nix-colors, ... }:

{
  imports =
    [ # Include other modules
      # Window Manager
      ./hyprland.nix
      # Applications
      ./apps.nix
      ./theme.nix
      ./bash.nix
    ];

  # Home Manager 
  home.username = "wally";
  home.homeDirectory = "/home/wally";
  home.stateVersion = "23.11"; # Please dont change

  # environment.
  home.packages = with pkgs; [
    dconf 
    mpv
    ghc
    #python3
    libnotify
    (python3.withPackages (ps: [ ps.pip ps.psutil ]))
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
    EDITOR="emacsclient -c -a 'emacs'";
    NIXOS_OZONE_WL = "1";    
    XKB_DEFAULT_LAYOUT = "de";
    VISUAL="bat --pager 'less'";
    PAGER="bat --pager 'less'";
    LIBVIRT_DEFAULT_URI="qemu:///system";
  };

  # SessionPath
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;

    # Emacs Configs
    emacs.enable = true;

    # Fuzzel App Launcher
    fuzzel = {
      enable = true;
      package = pkgs.fuzzel;
      settings = {
        main = {
          font = "FireCodeNerdFont";
          line-height = 20;
          width = 30;
          lines = 10;
          icons-enabled = "yes";
        };
        colors = {
          background = "282a36dd";
          text = "f8f8f2ff";
          match = "8be9fdff";
          selection-match = "8be9fdff";
          selection = "44475add";
          selection-text = "f8f8f2ff";
          border = "bd93f9ff";
        };
      };
    };
  };

}