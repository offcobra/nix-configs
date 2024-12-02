{ systemSettings, pkgs, config, ... }:

{
  imports = [
    # Picom config
    ./picom.nix

    # Nitrogen config
    ./nitrogen.nix

    # Rofi Config
    ./rofi.nix

    # URXVT Config
    ./urxvt.nix
  ];

  # Linking Qtile Files
  home.file = {
    ".config/qtile".source = ./qtile;
  };

  # Packages for Qtile
  home.packages = with pkgs; [
    picom
    nitrogen
    flameshot

    # Qtile Startup script
    (pkgs.writeShellScriptBin "qtile-startup" /*bash*/ ''
      if [[ ${systemSettings.hostname} == "mediatv" ]]
      then
        # Setting Screens MediaTV
        xrdb ~/.Xresources
        xrandr --output eDP-1 --off --output HDMI-1 --mode 1920x1080 --rate 60.00
        #screen_work
      fi

      echo "Fix for GTK Apps starting slow..."
      #/usr/lib/xdg-desktop-portal-gnome &
      dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY &

      echo "Setting Wallpapers"
      #nitrogen --restore &
      feh --bg-scale ~/.config/nixos/user/wallpapers/fantasy-landscape.png

      #echo "Start Picom..."
      #systemctl --user start picom

      #echo "Starting Flameshot Screenshot tool"
      #flameshot &

      echo "Starting Tray applets..."
      nm-applet &
      blueberry-tray &

      #echo "Start emacs daemon..."
      #emacs --daemon &

      if [[ ${systemSettings.hostname} == "workstation" ]]
      then
        echo "Starting Signal & WhatsApp..."
        flatpak run org.signal.Signal --start-in-tray &
        flatpak run com.rtosta.zapzap --start-hidden &

        # Setting custom resolution
        xrandr --newmode "1280x960_165.00"  310.25  1280 1392 1528 1776  960 963 967 1060 -hsync +vsync
        xrandr --addmode DisplayPort-1 1280x960_165.00

      elif [[ ${systemSettings.hostname} == "thinkpad" ]]
      then
        # Get Battery Notificaions
        watch_battery &
      fi
    '')

    # Kill Qtile Script
  ];

  home.file.".config/theme.json".text = ''
  {
      "background": ["#${config.colorScheme.palette.base00}", "#${config.colorScheme.palette.base00}"],
      "foreground": ["#${config.colorScheme.palette.base05}", "#${config.colorScheme.palette.base05}"],
      "active": ["#${config.colorScheme.palette.base0E}", "#${config.colorScheme.palette.base0E}"],
      "inactive": ["#${config.colorScheme.palette.base09}", "#${config.colorScheme.palette.base09}"],
      "color1": ["#${config.colorScheme.palette.base06}", "#${config.colorScheme.palette.base06}"],
      "color2": ["#${config.colorScheme.palette.base09}", "#${config.colorScheme.palette.base09}"],
      "color3": ["#${config.colorScheme.palette.base0C}", "#${config.colorScheme.palette.base0C}"],
      "color4": ["#${config.colorScheme.palette.base0D}", "#${config.colorScheme.palette.base0D}"]
  }
  '';
}
