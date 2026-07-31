{ pkgs, ... }:

{
  home.packages = [
    # ShellScript to set my Work Screen Layout
    (pkgs.writeShellScriptBin "screen-work.sh" /*bash*/ ''
      notify-send -t 5000 "Screen Mode" "Setting Screens to Work Mode..."

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
    '')
  ];
}
