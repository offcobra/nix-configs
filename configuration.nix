# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    tmp.cleanOnBoot = true;
    supportedFilesystems = [ "ntfs" ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "admgpu" ];
    loader = {
      #systemd-boot.enable = true;
      grub.configurationLimit = 5;
      grub.enable = true;
      grub.efiSupport = true;
      grub.efiInstallAsRemovable = true;
      grub.device = "nodev";
      grub.extraEntriesBeforeNixOS = true;
      grub.useOSProber = true;
      efi = {
        canTouchEfiVariables = false;
        efiSysMountPoint = "/boot";
      };
    };
  };

  #boot.kernelModules = [ "admgpu" ];
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.supportedFilesystems = [ "ntfs" ];

  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.swtpm.enable = true;
  virtualisation.docker.enable = true;
  
  networking.hostName = "nixos"; # Define your hostname.

  # Services
  services.flatpak.enable = true;
  #services.emacs.enable = true;

  # Services Mouse
  services.ratbagd.enable = true;
 
  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  #   useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable Hyprland
  programs.hyprland.enable = true;
  programs.waybar.enable = true;
  programs.hyprland.xwayland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";    
  
  # Steam gaming
  programs.steam.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;


  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  nixpkgs.config.allowUnfree = true;
  users.users.wally = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "storage" "libvirtd" "docker" "input" "disk" "kvm" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      starship
      lolcat
      distrobox
      k3d
      htop
      libnotify
      networkmanagerapplet
      python3
      python311Packages.pip
      shellcheck
      evince
      viewnior
      # Rust cli tools
      ripgrep
      du-dust
      procs
      tealdeer
      eww-wayland
      spotify
      zoxide
      popcorntime
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    gnugrep
    neofetch
    macchina
    vlc
    starship
    lolcat
    alacritty
    virt-manager
    virt-viewer
    virtio-win
    #pcmanfm
    dunst
    rofi
    wofi
    waybar
    git
    curl
    eza
    ansible
    bat
    bc
    jq
    lm_sensors
    gparted
    nerdfonts
    pciutils
    hyprland
    hyprpaper
    hyprland-protocols    
    wlr-randr
    k3d
    alsa-utils    
    hashcat
    hashcat-utils
    stress-ng    
    #brave
    glib
    # Themes
    #dracula-theme
    #dracula-icon-theme
    #catppuccin-cursors
    #lxappearance-gtk2
    #libsForQt5.qtstyleplugin-kvantum
    # Emacs dependency
    #emacs29
    #fd
    #libgcc
    #cmake
    #gnumake
    # Bluetooth
    bluez
    blueberry
    unzip
    # Rust + Programs
    rustc
    cargo
    rustup
    bottom
    # Pkill
    killall
    # themes
    beauty-line-icon-theme
    dracula-theme
    polkit_gnome
    os-prober
    exfat
    exfatprogs
    fastfetch
    grim
    slurp
    efibootmgr
  ];

  environment.localBinInPath = true;

  environment.variables = {
    #"QT_STYLE_OVERRIDE" = "kvantum";
    "QT_QPA_PLATFORMTHEME" = "gtk2";
    "GTK_THEME" = "Dracula";
    "ICON_THEME" = "BeautyLine";
  };

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

  fonts = {
    packages = with pkgs; [
      font-awesome
      source-code-pro
      (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
	      monospace = [ "Meslo LG M Regular Nerd Font Complete Mono" ];
	      serif = [ "Noto Serif" "Source Han Serif" ];
	      sansSerif = [ "Noto Sans" "Source Han Sans" ];
      };
    };
  }; 

  # Environment etc
  environment.etc = {
    "gtk-3.0".source = /home/wally/.config/gtk-3.0;
    "gtk-2.0".source = /home/wally/.config/gtk-2.0;
  };

  # qt Theme
  #qt.enable = true;
  #qt.platformTheme = "gtk2";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
  #   enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

