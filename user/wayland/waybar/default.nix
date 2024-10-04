{ config, pkgs, systemSettings, ... }:

let
  # Importing the stuff...
  bar = import ./mainBar.nix { inherit pkgs systemSettings; };
  style = import ./style.nix { inherit config; };
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
