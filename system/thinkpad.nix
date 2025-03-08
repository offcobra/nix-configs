# System configuration for my Thinkpad Laptop
{ pkgs, userSettings, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./thinkpad/thinkpad-hardware.nix
      # Hyprland Stuff
      ./helper/hyprland.nix
      # Qtile Stuff...
      ./helper/qtile.nix
      # Nix Settings
      ./helper/nix-settings.nix
      # Fonts config
      ./helper/fonts.nix
      # Ollama AI Service
      ./helper/ollama.nix
      # Gnome polkit
      ./helper/polkit.nix
      # Sudo Security
      ./helper/security.nix
      # Set Locales
      ./helper/locales.nix
      # Virtualization Stuff...
      ./helper/virtualization.nix
      # Set TUIGreet
      ./helper/tuigreet.nix
      # Flatpaks
      ./helper/flatpak.nix
      # Sound
      ./helper/pipewire.nix
    ];

  # Env Variablen
  environment.sessionVariables.WINIT_HIDPI_FACTOR = "1";

  # Enable networking
  networking = {
    hostName = "thinkpad"; # Define your hostname.
    networkmanager.enable = true;
  };

  # Laptop Services
  programs.light.enable = true;
  services.upower.enable = true;

  # Fingerprint reader
  services.fprintd = {
    enable = true;
    #package = pkgs.fprintd-tod;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-vfs0090;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "storage" "video" "docker" "input" "disk" ];
    packages = with pkgs; [
        acpi
        libnotify
        lm_sensors
        alsa-utils
        powertop
        linuxKernel.packages.linux_zen.cpupower
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = import ./helper/system_packages.nix pkgs;

  services.dbus.enable = true;

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
       START_CHARGE_THRESH_BAT0 = 50; # 40 and bellow it starts to charge
       STOP_CHARGE_THRESH_BAT0 = 98; # 80 and above it stops charging

      };
  };

  # Dont Change...
  system.stateVersion = "23.05"; # Did you read the comment?
}
