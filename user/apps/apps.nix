{ config, pkgs, ... }:

{
  imports =
    [ # Include other modules
      # Dunst Config
      ./dunst.nix
      # Emacs Config
      ./emacs.nix
      # Alacritty Config
      ./alacritty.nix
    ];

  # List of secondary Applications
  home.packages = with pkgs; [
    brave
    qutebrowser
    networkmanagerapplet
    libreoffice-fresh
    looking-glass-client
    pavucontrol
    freerdp
    remmina
    evince
    viewnior
    #spotify
    popcorntime
    pcmanfm
    brave
    vlc
    gparted
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
  ];
}
