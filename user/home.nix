{ config, pkgs, epkgs, ... }:

{
  imports =
    [ # Include other modules
      # Window Manager
      ./hyprland.nix
      # Applications
      ./apps.nix
      ./theme.nix
    ];

  # Home Manager 
  home.username = "wally";
  home.homeDirectory = "/home/wally";
  home.stateVersion = "23.11"; # Please dont change

  # environment.
  home.packages = with pkgs; [
    hello

    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    #".icons/beautyline".source = "${pkgs.beauty-line-icon-theme}/share/icons/Beautyline";
    ".icons/BeautyLine".source = "${pkgs.beauty-line-icon-theme}/share/icons/Beautyline";
    ".themes/Catppuccin-Frappe-Standard-Blue-Dark".source = "${pkgs.catppuccin-gtk}/share/themes/Catppuccin-Frappe-Standard-Blue-Dark";
    ".themes/Dracula".source = "${pkgs.dracula-theme}/share/themes/Dracula";

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/wally/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    NIXOS_OZONE_WL = "1";    
    XKB_DEFAULT_LAYOUT = "de";

  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    emacs.enable = true;
  };

}
