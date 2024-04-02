{ config, pkgs, ... }:

{
  imports =
    [ # Include other modules
      # Applications
      ./apps.nix
      # Bash stuff
      ./bash.nix
      # Terminals
      ./alacritty.nix
      ./foot.nix
      # Launcher
      ./fuzzel.nix
    ];

  # Window Manager
  #wayland.windowManager.hyprland = {
  #  enable = false;
  #  xwayland = { enable = true; };
  #  systemd.enable = true;
  #};

  home.packages = with pkgs; [
    grim
    slurp
    distrobox
    k3d
    dunst
    dysk
    # Terminals
    alacritty
    foot
    # Bars
    waybar
    eww
    hyprland
    hyprpaper
    hyprland-protocols    
    # Rust + Programs
    rustup
    bottom
  ];
}


# Theme packages
#nwg-look
#dracula-theme
#catppuccin
#gruvbox-gtk-theme
#gruvbox-dark-icons-gtk
#gnome.adwaita-icon-theme
#numix-cursor-theme
#material-cursors
#beauty-line-icon-theme
#candy-icons
# Themes done
