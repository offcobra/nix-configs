{ inputs, config, pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
  programs.waybar.enable = false;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";    
  environment.sessionVariables.XKB_DEFAULT_LAYOUT = "de";
  
  # Enable Portal
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk 
      #pkgs.xdg-desktop-portal-hyprland
    ];
  };

  # Additional needed Hyprland packages
  environment.systemPackages = with pkgs; [
    hyprland-protocols
    hyprpaper
    hyprlock
    hypridle
    wlr-randr
    waybar
  ];
}
