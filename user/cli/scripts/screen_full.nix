{ pkgs, userSettings, ... }:

let
  QTILE_HOME = "/home/${userSettings.username}/.config/qtile/settings/";
in
{
  home.packages = [
    # ShellScript to set my Full Screen Layout
    (pkgs.writeShellScriptBin "screen-full.sh" /*bash*/ ''
      notify-send -t 5000 "Screen Mode" "Setting Screens to Full Mode..."

      if [[ $(pgrep Hyprland) ]]
      then
          # Kill HyprPaper
          killall hyprpaper

          # Setting Hyprland screens
          echo "Setting WRandR mode ... "
          wlr-randr --output DP-1 --on --pos 0,0 --mode 1920x1080@144.001007Hz \
              --output DP-2 --on --pos 1920,0 --mode 1920x1080@164.996994Hz \
              --output DP-3 --on --pos 3840,0

          echo "Setting Wallpapers"
          hyprpaper &
          hyprctl reload

      else
          echo "Setting XRandR mode ... "
          xrandr --output DisplayPort-0 --mode 1920x1080 --rate 144.00 --pos 0x0 --rotate normal \
      	      --output DisplayPort-1 --mode 1920x1080 --rate 165.00 --pos 1920x0 --rotate normal \
      	      --output DisplayPort-2 --mode 1920x1080 --rate 60.00 --pos 3840x0 --rotate normal \
              --output HDMI-A-1 --off

          echo "Restoring Wallpapers with nitrogen ... "
          nitrogen --restore

          echo "Setting Qtile 3Screens mode ... "
          [ -f ${QTILE_HOME}screens.py ] && rm ${QTILE_HOME}screens.py
          ln -s ${QTILE_HOME}custom_screens/3screens.py ${QTILE_HOME}screens.py

          echo "Restarting Qtile..."
          qtile cmd-obj -o cmd -f reload_config
      fi
    '')
  ];
}