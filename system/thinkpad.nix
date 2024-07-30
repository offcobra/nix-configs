{ pkgs, userSettings, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./thinkpad/thinkpad-hardware.nix
      # Hyprland Stuff
      ./helper/hyprland.nix
      # Nix Settings
      ./helper/nix-settings.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 3;
  boot.loader.efi.canTouchEfiVariables = true;

  # Latest Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable networking
  networking.hostName = "thinkpad"; # Define your hostname.
  networking.networkmanager.enable = true;

  virtualisation.docker.enable = true;
  #virtualisation.podman.enable = true;

  programs.light.enable = true;

  # Services
  services.flatpak.enable = true;
  services.emacs.enable = true;
  services.upower.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Fingerprint reader
  services.fprintd = {
    enable = true;
    #package = pkgs.fprintd-tod;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-vfs0090;
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  #   useXkbConfig = true; # use xkbOptions in tty.
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  nixpkgs.config.allowUnfree = true;
  users.users.${userSettings.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "storage" "video" "docker" "input" "disk" ];
    packages = with pkgs; [
        # Cli tools
        git
        nh
        curl
        wget
        vim
        starship
        zoxide
        lolcat
        htop
        ripgrep
        fd
        du-dust
        procs
        tealdeer
        git
        curl
        eza
        bat
        bc
        jq
        lm_sensors
        libnotify
        acpi
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
    os-prober
    exfat
    exfatprogs
    efibootmgr
  ];

  services.dbus.enable = true;

  security.polkit.enable = true;

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
  # programs.mtr.enable = true;
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
}
