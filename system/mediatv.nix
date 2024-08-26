# System COnfiguration for MediaTv Laptop
{ pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./mediatv/hardware-configuration.nix
      # Virtualization Stuff...
      ./helper/virtualization.nix
      # Hyprland Stuff...
      ./helper/hyprland.nix
      # Qtile Stuff...
      ./helper/qtile.nix
      # Nix Settings
      ./helper/nix-settings.nix
      # Gnome polkit
      ./helper/polkit.nix
      # Set Locales
      ./helper/locales.nix
    ];

  # Enable networking
  networking = {
    hostName = "mediatv"; # Define your hostname.
    networkmanager.enable = true;
  };

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
    wireplumber.enable = true;
  };

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
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    hwloc
    curl
    gnugrep
    lm_sensors
    pciutils
    os-prober
    exfat
    exfatprogs
    efibootmgr
  ];

  services.dbus.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.gnupg.agent = {
    enable = true;
  #   enableSSHSupport = true;
  };

  # Power Management
  services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 100;

       #Optional helps save long term battery health
       START_CHARGE_THRESH_BAT0 = 30; # 40 and bellow it starts to charge
       STOP_CHARGE_THRESH_BAT0 = 98; # 80 and above it stops charging

      };
  };

  # Dont Delete
  system.stateVersion = "23.11"; # Did you read the comment?
}
