{ pkgs, ... }:

{
  home.packages = [
    # ShellScript to set my Chill Screen Layout
    (pkgs.writeShellScriptBin "screen-chill.sh" /*bash*/ ''
      notify-send -t 5000 "Screen Mode" "Setting Screens to Chill Mode..."

        # Kill HyprPaper
        echo "Kill Wallpapers"
        kill -9 $(pgrep hyprpaper)

        # Setting Hyprland screens
        echo "Setting Chill Monitor Mode..."
        hyprctl keyword monitor DP-1,1920x1080@144.00,0x0,1
        hyprctl keyword monitor DP-2,1920x1080@165.00,1920x0,1
        hyprctl keyword monitor DP-3,disabled

        echo "Setting Wallpapers"
        hyprpaper &
    '')
  ];
}
