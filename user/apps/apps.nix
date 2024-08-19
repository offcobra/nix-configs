{ pkgs, lib, allowed-unfree-packages, ... }:

{
  imports =
    [ # Include other modules
      # Dunst Config
      ./dunst.nix
      # Emacs Config
      ./emacs.nix
      # Alacritty Config
      ./alacritty.nix
      # Wezterm Config
      #./wezterm.nix
      # Brave Config
      ./brave.nix
      # Freetube Config
      ./freetube.nix
    ];

    nixpkgs.config = {
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowed-unfree-packages;
    };

  # List of secondary Applications
  home.packages = with pkgs; [
    #gpt4all
    #qutebrowser
    networkmanagerapplet
    libreoffice-fresh
    thunderbird-bin
    looking-glass-client
    pavucontrol
    freerdp
    remmina
    evince
    viewnior
    spotify
    popcorntime
    pcmanfm
    vlc
    #gparted
    # Bluetooth
    bluez
    blueberry
    # Virtio
    virt-manager
    virt-viewer
    # Terminals
    alacritty
    # Bars
    eww
    webcord
    obsidian
    # Bitwarden
    bitwarden-desktop
    bitwarden-cli
  ];
}