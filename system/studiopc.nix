# StudioPc Configurations
{ pkgs, systemSettings, userSettings, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./studiopc/hardware-configuration.nix
      # Set Locales
      ./helper/locales.nix
      # Gnome De
      ./helper/gnome.nix
      # Nix Settings
      ./helper/nix-settings.nix
      # File Manager
      ./helper/thunar.nix
      # Sound
      ./helper/pipewire.nix
      # Flatpaks
      ./helper/flatpak.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = systemSettings.kernel;

  networking.hostName = "studiopc"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

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

  users.users.lisa = {
    isNormalUser = true;
    extraGroups = [ "audio" "networkmanager" "storage" ];
    packages = with pkgs; [
      tree
    ];
  };

  # List packages installed in system profile.
  environment.systemPackages = import ./helper/system_packages.nix pkgs;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Dont Change...
  system.stateVersion = "25.11"; # Did you read the comment?
}
