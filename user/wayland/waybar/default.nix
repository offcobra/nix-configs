{ config, pkgs, systemSettings, userSettings, ... }:

let
  # Importing the stuff...
  bar = import ./mainBar.nix { inherit pkgs systemSettings; };
  style = import ./style.nix { inherit config userSettings; };
  settings = if (systemSettings.hostname == "workstation")
    then
      [bar.mainBar bar.secondBar]
    else
      [bar.mainBar];
in
{
  # Waybar Config
  programs.waybar = {
    enable = true;
    settings = settings;
    style = style.style;
  };
}
