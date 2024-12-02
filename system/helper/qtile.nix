{ pkgs, systemSettings, ... }:

let
  drivers = if (systemSettings.hostname == "workstation")
    then
      [ "amdgpu-pro" "amdgpu" ]
    else
      [ "modesetting" "fbdev" ];
in
{
  # Enable Qtile
  services = {
    xserver = {
      enable = true;
      xkb.layout = "de";
      displayManager.startx.enable = true;
      videoDrivers = drivers;
      windowManager.qtile = {
        enable = true;
        extraPackages = python3Packages: with python3Packages; [
          prettytable
          psutil
        ];
      };
    };
    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
        accelSpeed = "0";
      };
    };
  };

  # Enable Portal
  xdg.portal = {
    enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Additional needed Hyprland packages
  environment.systemPackages = with pkgs; [
    feh
    picom
    rofi
    nitrogen
    xorg.libxcvt
    xorg.xhost
  ];
}
