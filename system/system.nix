# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Boot Stuff
      ./boot.nix
      # Steam Stuff ?- here for now...
      ./steam.nix
      # Steam Stuff ?- here for now...
      ./virtualization.nix
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
  
  # Dns conf
  #environment.etc = {
  # "resolv.conf".text = "nameserver 208.67.222.222\nnameserver 208.67.220.220\n";
  #};

  # Services
  services.flatpak.enable = true;
  #services.emacs.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    socketActivation = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  #   useXkbConfig = true; # use xkbOptions in tty.
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  nixpkgs.config.allowUnfree = true;
  users.users.wally = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "storage" "libvirtd" "qemu-libvirtd" "docker" "input" "disk" "kvm" ]; 
    packages = with pkgs; [
        # Base tools
        bc
        jq
        git
        vim
        curl
        wget
        # Nix Helper
        nh
        # Rust cli tools
        fd
        bat
        eza
        procs
        zoxide
        lolcat
        du-dust
        ripgrep
        starship
        # More tools
        htop
        tealdeer
        neofetch
        libnotify
        wlr-randr
        lm_sensors
        alsa-utils
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    hwloc
    curl
    gnugrep
    lm_sensors
    pciutils
    wlr-randr
    os-prober
    exfat
    exfatprogs
    efibootmgr
  ];

  services.dbus.enable = true;

  security.polkit.enable = true;
  
  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 wally kvm -"
  ];

  systemd = {
  user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
  };
};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.gnupg.agent = {
    enable = true;
  #   enableSSHSupport = true;
  };

  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
  
  nix = {
    settings = {
      warn-dirty = true;
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
