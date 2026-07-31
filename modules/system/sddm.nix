# Aspect: sddm -- catppuccin-themed Wayland login manager.
{ config, ... }:
let
  c = config.constants;
in
{
  flake.modules.nixos.sddm =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        (pkgs.catppuccin-sddm.override {
          flavor = "mocha";
          accent = "mauve";
          font = c.font;
          fontSize = "9";
          clockEnabled = true;
          background = ./assets/midnight-sea.jpg;
          loginBackground = true;
        })
        pkgs.sddm-sugar-dark
      ];

      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        theme = "catppuccin-mocha-mauve";
      };
    };
}
