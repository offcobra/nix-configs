{ config, pkgs, ... }:

{
  # List of secondary Applications
  home.packages = with pkgs; [
    brave
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
    pciutils
    # Bluetooth
    bluez
    blueberry
    # Virtio
    virt-manager
    virt-viewer
  ];
}

