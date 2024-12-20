{ pkgs, userSettings, ... }:

let
  QTILE_HOME = "/home/${userSettings.username}/.config/qtile/settings/";
in
{
  home.packages = [
    # ShellScript to set my Work Screen Layout
    (pkgs.writeShellScriptBin "screen-work.sh" /*bash*/ ''
      notify-send -t 5000 "Screen Mode" "Setting Screens to Work Mode..."

      if [[ $(pgrep Hyprland) ]]
      then
          # Kill HyprPaper
          echo "Killing Wallpapers"
          kill -9 $(pgrep hyprpaper)

          # Setting Hyprland screens
          echo "Setting Work mode..."
          hyprctl keyword monitor DP-1,1920x1080@144.00,0x0,1
          hyprctl keyword monitor DP-2,disabled
          hyprctl keyword monitor DP-3,disabled

          # Set Wallpaper
          echo "Setting Wallpapers"
          hyprpaper &

      else
          echo "Setting XRandR mode ... "
          xrandr --output DisplayPort-0 --mode 1920x1080 --rate 144.00 --pos 0x0 --rotate normal \
      	    --output DisplayPort-1 --off \
      	    --output DisplayPort-2 --off \
            --output HDMI-A-1 --off

          echo "Restoring Wallpapers with nitrogen ... "
          nitrogen --restore

          # Setting Qtile Screens
          echo "Setting Qtile 1Screens mode ... "
          [ -f ${QTILE_HOME}screens.py ] && rm ${QTILE_HOME}screens.py
          ln -s ${QTILE_HOME}custom_screens/1screens.py ${QTILE_HOME}screens.py

          echo "Restarting Qtile..."
          qtile cmd-obj -o cmd -f reload_config
      fi
    '')
  ];
}
