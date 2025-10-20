{ pkgs, userSettings, ... }:

{
  # Gaming
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
      gamescopeSession.enable = true;
    };
    gamemode.enable = true;
  };

  # Bleeding-Edge MESA
  chaotic.mesa-git.enable = false;

  # Required Packages
  environment.systemPackages = with pkgs; [
    protonup
  ];

  # Env Variable for Protonup
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${userSettings.username}/.steam/root/compatibilitytools.d";
  };
}
