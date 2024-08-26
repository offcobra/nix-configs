{ pkgs, ... }:

{
  # Enable Qtile
  services = {
    xserver = {
      enable = true;
      xkb.layout = "de";
      displayManager.startx.enable = true;
      videoDrivers = [ "amdgpu" ];
      windowManager.qtile = {
        enable = true;
        #backend = "x11";
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
    picom
    rofi
    nitrogen
    xorg.libxcvt
    xorg.xhost
  ];
}
