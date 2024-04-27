{ config, pkgs, nix-colors, userSettings, ... }:

{
  imports =
    [ # Include other modules
      nix-colors.homeManagerModules.default
      # Window Manager
      ./wayland/hyprland.nix
      # Bash Config
      ./bash.nix
      # Gtk Themes
      ./theme.nix
      # Terminal
      ./alacritty.nix
      # Applications
      ./apps.nix
    ];
  colorScheme = nix-colors.colorSchemes.${userSettings.colorTheme};

  # Home Manager 
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;
  home.stateVersion = "23.11"; # Please dont change

  # environment.
  home.packages = with pkgs; [
    dconf 
    mpv
    ghc
    #python3
    libnotify
    networkmanagerapplet
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
    VISUAL="vim";
    PAGER="bat --pager 'less'";
    LIBVIRT_DEFAULT_URI="qemu:///system";
    FLAKE="/home/wally/.config/nixos";
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
    emacs.extraPackages = epkgs: [ epkgs.vterm ];
    
    # NetworkManager applet
    #nm-applet.enable = true;

    # Vim Settings 
    vim = {
      enable = true;
      settings = {
        expandtab = true;
        shiftwidth = 4;
        tabstop = 4;
      };
      extraConfig = ''
        syntax enable
        set incsearch
        set hlsearch
        set autoindent
        set number relativenumber
        " Dracula Colors
        " packadd! dracula
        " colorscheme dracula
      '';
    };
    
    # Git Version Control
    git = {
      enable = true;
      userName = userSettings.name;
      userEmail = userSettings.email;
    };

    # Bat a Better Cat 
    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "Dracula";
      };
    };
  };
}
