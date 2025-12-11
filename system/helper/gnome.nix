{ pkgs, ... }:

{
  # Enable gnome
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    gnome-maps
    geary
  ];

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    whitesur-gtk-theme
    whitesur-cursors
    whitesur-icon-theme
    video-downloader
    tenacity
    audacity
    brave
    pavucontrol
  ];
}
