{ pkgs, userSettings, ... }:

{
  # Gaming
  programs = {
    steam = {
      enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ]; # declarative GE-Proton, pick it per game
      protontricks.enable = true;
      remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
      gamescopeSession.enable = true;
    };
    gamemode.enable = true;
  };

  # Required Packages
  environment.systemPackages = with pkgs; [
    pkgs.python313Packages.ds4drv
    protonup-ng
  ];

  # Env Variable for Protonup
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${userSettings.username}/.steam/root/compatibilitytools.d";
  };
}
