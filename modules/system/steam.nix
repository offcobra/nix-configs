# Aspect: steam -- gaming (steam + gamescope + gamemode + protonup).
{ config, ... }:
let
  c = config.constants;
in
{
  flake.modules.nixos.steam =
    { pkgs, ... }:
    {
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = false;
        dedicatedServer.openFirewall = false;
        gamescopeSession.enable = true;
      };
      programs.gamemode.enable = true;

      environment.systemPackages = with pkgs; [
        python313Packages.ds4drv
        protonup-ng
      ];

      environment.sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${c.username}/.steam/root/compatibilitytools.d";
      };
    };
}
