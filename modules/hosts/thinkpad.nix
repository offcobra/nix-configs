# Host: thinkpad -- laptop. Hyprland, no VFIO/steam/ollama; adds laptop power
# management and the fingerprint reader.
{ inputs, config, ... }:
let
  c = config.constants;
  system = "x86_64-linux";
  userSettings = {
    inherit (c) username name email theme colorTheme iconTheme cursorTheme font;
    inherit system;
  };
  systemSettings = {
    hostname = "thinkpad";
    inherit system;
    inherit (c) timezone locale;
    kernel = "linuxPackages_latest";
  };
in
{
  flake.modules.nixos.thinkpad =
    { pkgs, ... }:
    {
      imports = [ ./_hw/thinkpad.nix ];

      networking.hostName = "thinkpad";

      environment.sessionVariables.WINIT_HIDPI_FACTOR = "1";

      services.upower.enable = true;
      services.dbus.enable = true;
      programs.gnupg.agent.enable = true;

      # Fingerprint reader
      services.fprintd = {
        enable = true;
        tod = {
          enable = true;
          driver = pkgs.libfprint-2-tod1-goodix;
        };
      };

      # Laptop power management
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
          START_CHARGE_THRESH_BAT0 = 50;
          STOP_CHARGE_THRESH_BAT0 = 98;
        };
      };

      users.users.${c.username}.packages = with pkgs; [
        acpi
        powertop
        linuxKernel.packages.linux_zen.cpupower
      ];
    };

  flake.nixosConfigurations.thinkpad = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      { nixpkgs.hostPlatform = system; }
    ]
    ++ (with config.flake.modules.nixos; [
      base
      wally
      thinkpad
      hyprland
      sddm
      fonts
      thunar
      pipewire
      flatpak
      polkit
      security
      virtualization
    ]);
  };

  flake.homeConfigurations."wally@thinkpad" =
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
        hyprlandThinkpad
      ];
    };
}
