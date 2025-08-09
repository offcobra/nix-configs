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
    #birdtray
  ];

  # Utils
  utils = with pkgs; [
    # Bars
    eww

    obsidian  # Note taking
    #webcord   # Wayland Discord

    # Crypto Wallet
    # Todo -> Wont build....
    #(exodus.overrideAttrs {
    #  version = "24.51.4";

    #  src = requireFile {
    #    name = "exodus-linux-x64-24.51.4.zip";
    #    url = "https://downloads.exodus.com/releases/exodus-linux-x64-24.51.4.zip";
    #    hash = "sha256-lUL9n3EZVe2J7uCHUSJgI2g75Sp1Y/nfBTde7VId6sA=";
    #  };
    #})
  ];

  # Pass
  pass-manager = with pkgs; [
  #  # Bitwarden Password Manager
    bitwarden-desktop
  #  #bitwarden-cli
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
      # Terminals
      ./terminals
      # Dunst Config
      ./dunst.nix
      # Emacs Config
      #./emacs.nix
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
    pwvucontrol

    # Bluetooth
    bluez
    blueberry
  ] ++ packages;      # Added packges for specific System
}
