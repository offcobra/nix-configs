{ pkgs, ... }:

{
  # Enable gnome
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    nautilus
    gnome-maps
    geary
  ];
}
