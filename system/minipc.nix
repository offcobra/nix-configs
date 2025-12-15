# System Configuration for my MiniPC
{ pkgs, userSettings, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./minipc/hardware-configuration.nix
      # Nix Settings
      ./helper/nix-settings.nix
      # Fonts config
      ./helper/fonts.nix
      # File Manager
      ./helper/thunar.nix
      # Steam Stuff ?- here for now...
      ./helper/steam.nix
      # Hyprland Stuff...
      ./helper/hyprland.nix
      # Gnome polkit
      ./helper/polkit.nix
      # Sudo Security
      ./helper/security.nix
      # Set Locales
      ./helper/locales.nix
      ./helper/sddm.nix
      # Flatpaks
      ./helper/flatpak.nix
      # Sound
      ./helper/pipewire.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
  networking.hostName = "minipc"; # Define your hostname.
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "de";
   };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "storage" "libvirtd" "qemu-libvirtd" "podman" "docker" "input" "disk" "kvm" ];
    packages = with pkgs; [
        libnotify
        lm_sensors
        alsa-utils
        # android fs
        jmtpfs
        usbutils
        glib
    ];
  };

  # List packages installed in system profile.
  environment.systemPackages = import ./helper/system_packages.nix pkgs;

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Dont delete..
  system.stateVersion = "25.11"; # Did you read the comment?
}

