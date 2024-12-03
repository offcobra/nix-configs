{ pkgs, lib, allowed-unfree-packages, systemSettings, ... }:

let
  # Virtio Machines
  virtualisation = with pkgs; [
    looking-glass-client
    quickemu
    virt-manager
    virt-viewer
    freerdp3
  ];

  # Office Apps
  office = with pkgs; [
    libreoffice-fresh
    thunderbird-bin
  ];

  # Utils
  utils = with pkgs; [
    # Bars
    eww

    obsidian  # Note taking
    webcord   # Wayland Discord

    # Crypto Wallet
    # Todo -> Wont build....
    #exodus
  ];

  # Pass
  pass-manager = with pkgs; [
    # Bitwarden Password Manager
    bitwarden-desktop
    bitwarden-cli
  ];

  # Choose packages for specific system
  packages = if ( systemSettings.hostname == "workstation")
              then
                virtualisation ++ office ++ utils ++ pass-manager
              else if ( systemSettings.hostname == "thinkpad")
              then
                pass-manager
              else [];
in
{
  imports =
    [ # Include other modules
      # Dunst Config
      ./dunst.nix
      # Emacs Config
      ./emacs.nix
      # Alacritty Config
      ./alacritty.nix
      # Kitty Config
      ./kitty.nix
      # Wezterm Config
      #./wezterm.nix
      # Brave Config
      ./brave.nix
      ./qutebrowser.nix
      # Freetube Config
      ./freetube.nix
      # Zathura PDF Config
      ./zathura.nix
      # Vim - Image viewer
      ./imv.nix
    ];

    nixpkgs.config = {
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowed-unfree-packages;
    };

  # List of secondary Applications
  home.packages = with pkgs; [
    # Network Manager
    networkmanagerapplet

    # Image viewer
    loupe

    # File Manager
    pcmanfm

    # Media Player
    mpv
    vlc
    spotify
    pavucontrol

    # Disk Manager
    gparted

    # Bluetooth
    bluez
    blueberry
  ] ++ packages;      # Added packges for specific System
}
