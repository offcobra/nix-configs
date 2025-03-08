# System Configuration for MediaTv Laptop
{ pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./mediatv/hardware-configuration.nix
      # Virtualization Stuff...
      ./helper/virtualization.nix
      # Hyprland Stuff...
      #./helper/hyprland.nix
      # Qtile Stuff...
      ./helper/qtile.nix
      # Fonts config
      ./helper/fonts.nix
      # Nix Settings
      ./helper/nix-settings.nix
      # Gnome polkit
      ./helper/polkit.nix
      # Set Locales
      ./helper/locales.nix
      # Virtualization Stuff...
      ./helper/virtualization.nix
      # Sound
      ./helper/pipewire.nix
    ];

  # Enable networking
  networking = {
    hostName = "mediatv"; # Define your hostname.
    networkmanager.enable = true;
  };

  # Autologin
  services.getty.autologinUser = "wally";

  # Services
  services.flatpak.enable = true;
  #services.emacs.enable = true;
  services.openssh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wally = {
    isNormalUser = true;
    description = "Wally";
    extraGroups = [ "wheel" "networkmanager" "storage" "libvirtd" "qemu-libvirtd" "docker" "input" "disk" "kvm" ];
    packages = with pkgs; [
      # Base tools
      libnotify
      lm_sensors
      alsa-utils
    ];
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = import ./helper/system_packages.nix pkgs;

  services.dbus.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.gnupg.agent = {
    enable = true;
  #   enableSSHSupport = true;
  };

  # Power Management
  powerManagement = {
      enable = true;
      cpuFreqGovernor = "performance";
  };

  # Dont Delete
  system.stateVersion = "23.11"; # Did you read the comment?
}
