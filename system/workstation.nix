# System Configuration for my Main Workstation
{ pkgs, userSettings, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./workstation/hardware-configuration.nix
      # Nix Settings
      ./helper/nix-settings.nix
      # Boot Stuff
      ./workstation/boot.nix
      # Steam Stuff ?- here for now...
      ./helper/steam.nix
      # Virtualization Stuff...
      ./helper/virtualization.nix
      # Hyprland Stuff...
      ./helper/hyprland.nix
      # Qtile Stuff...
      ./helper/qtile.nix
      # Ollama AI Service
      ./helper/ollama.nix
      # Gnome polkit
      ./helper/polkit.nix
      # Set Locales
      ./helper/locales.nix
      # Set TUIGreet
      ./helper/tuigreet.nix
    ];

  # Pick networking options.
  networking = {
    #bridges.br-lan.interfaces = [ "enp14s0" ];
    hostName = "workstation"; # Define your hostname.
    networkmanager = {
      enable = true;
    };
    enableIPv6 = false;
    #nameservers = [
    #  "208.67.222.222"
    #  "208.67.220.220"
    #  "8.8.8.8"
    #  "8.8.4.4"
    #];
  };

  # Services
  services.flatpak.enable = true;
  services.gvfs.enable = true;

  # Emacs service
  #services.emacs.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
    socketActivation = true;
    wireplumber.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "storage" "libvirtd" "qemu-libvirtd" "docker" "input" "disk" "kvm" ];
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

  # Define Test User
  users.users.test = {
    isNormalUser = true;
    createHome = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = import ./helper/system_packages.nix pkgs;

  services.dbus.enable = true;

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 ${userSettings.username} kvm -"
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.gnupg.agent = {
    enable = true;
  #   enableSSHSupport = true;
  };

  # Dont Change...
  system.stateVersion = "23.05"; # Did you read the comment?
}
