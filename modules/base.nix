# Aspect: base -- the floor every host stands on.
#
# system.stateVersion is deliberately NOT set here: it is per-machine identity
# and lives in each host's _hw file. home.stateVersion is per-user and lives in
# the user aspect.
{ config, ... }:
let
  c = config.constants;
in
{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      nix.settings = {
        warn-dirty = true;
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = true;
        substituters = [ "https://hyprland.cachix.org" ];
        trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
      };
      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };

      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.nvidia.acceptLicense = true;

      time.timeZone = c.timezone;
      i18n.defaultLocale = c.locale;
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
      };

      networking.networkmanager.enable = true;

      environment.systemPackages = with pkgs; [
        vim
        wget
        hwloc
        curl
        gnugrep
        gparted
        lm_sensors
        pciutils
        os-prober
        exfat
        exfatprogs
        efibootmgr
      ];
    };

  flake.modules.homeManager.base = {
    programs.home-manager.enable = true;
    xdg.enable = true;
  };
}
