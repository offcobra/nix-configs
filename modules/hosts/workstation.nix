# Host: workstation -- the composition point.
#
# Read top to bottom to know what this machine is: two lists of aspect names,
# one per class. Host-UNIQUE system config (networking, DNS, looking-glass) is
# the `workstation` aspect below; everything reusable is its own aspect file.
{ inputs, config, ... }:
let
  c = config.constants;
  system = "x86_64-linux";

  # Compatibility bridge: the relocated leaf modules under home/_src still read
  # `userSettings`/`systemSettings`. Rather than rewrite ~40 leaves, we DERIVE
  # those attrsets from the single source of truth (config.constants) and hand
  # them to the HM module tree via extraSpecialArgs. No values are duplicated.
  userSettings = {
    inherit (c) username name email theme colorTheme iconTheme cursorTheme font;
    inherit system;
  };
  systemSettings = {
    hostname = "workstation";
    inherit system;
    inherit (c) timezone locale;
    kernel = "linuxPackages_latest";
  };
in
{
  flake.modules.nixos.workstation =
    { pkgs, ... }:
    {
      imports = [ ./_hw/workstation.nix ];

      networking = {
        hostName = "workstation";
        enableIPv6 = false;
        nameservers = [
          "208.67.222.222"
          "208.67.220.220"
          "8.8.8.8"
          "8.8.4.4"
        ];
        hosts = {
          "192.168.122.2" = [ "homelab.local" ];
        };
        firewall = {
          enable = true;
          allowedUDPPorts = [ 53 67 ];
        };
      };

      programs.localsend = {
        enable = true;
        openFirewall = true;
      };
      programs.gnupg.agent.enable = true;

      services.gvfs.enable = true;
      services.dbus.enable = true;

      # Shared memory node for looking-glass (VFIO VM display).
      systemd.tmpfiles.rules = [
        "f /dev/shm/looking-glass 0660 ${c.username} kvm -"
      ];

      users.users.test = {
        isNormalUser = true;
        createHome = true;
      };
    };

  flake.nixosConfigurations.workstation = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      { nixpkgs.hostPlatform = system; }
    ]
    ++ (with config.flake.modules.nixos; [
      base
      wally
      workstation
      # desktop
      hyprland
      sddm
      fonts
      thunar
      # services
      pipewire
      flatpak
      polkit
      security
      ollama
      steam
      virtualization
    ]);
  };

  flake.homeConfigurations."wally@workstation" =
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      extraSpecialArgs = {
        inherit inputs userSettings systemSettings;
        nixvim = inputs.nixvim;
        nix-colors = inputs.nix-colors;
        allowed-unfree-packages = c.allowedUnfreePackages;
      };
      modules = with config.flake.modules.homeManager; [
        base
        wally
        colors
        homeCore
        cli
        theme
        apps
        wayland
        hyprland
      ];
    };
}
