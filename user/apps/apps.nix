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
    gpt4all
    brave
    freetube
    qutebrowser
    bitwarden-desktop
    bitwarden-cli
    networkmanagerapplet
    libreoffice-fresh
    thunderbird-bin
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
