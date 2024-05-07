{ config, pkgs, ... }:

{
  # Settings graphics Driver
  # Loading kernel module for Wayland and X11
  services.xserver = {
    enable = true; 
    videoDrivers = [ "amdgpu" ]; 
  };

  # Gaming
  # Steam gaming
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  # Required Packages
  environment.systemPackages = with pkgs; [
    gamemode
    glxinfo
    protonup-qt
  ];
}
