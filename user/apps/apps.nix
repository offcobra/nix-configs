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

  # Services
  services.copyq.enable = true;

  # List of secondary Applications
  home.packages = with pkgs; [
    obsidian  # Note taking
    webcord   # Wayland Discord

    # Office Apps
    libreoffice-fresh
    thunderbird-bin

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
    spicetify-cli
    pavucontrol

    # Disk Manager
    gparted

    # Bluetooth
    bluez
    blueberry

    # Virtio Machines
    looking-glass-client
    quickemu
    virt-manager
    virt-viewer
    freerdp3

    # Bars
    eww

    # Bitwarden Password Manager
    bitwarden-desktop
    bitwarden-cli

    # Crypto Wallet
    # Todo -> Wont build....
    #exodus
  ];
}
