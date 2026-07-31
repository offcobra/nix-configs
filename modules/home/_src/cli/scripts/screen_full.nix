{ pkgs, ... }:

{
  home.packages = [
    # ShellScript to set my Full Screen Layout
    (pkgs.writeShellScriptBin "screen-full.sh" /*bash*/ ''
      notify-send -t 5000 "Screen Mode" "Setting Screens to Full Mode..."

        # Kill HyprPaper
        echo "Killing Wallpapers"
        kill -9 $(pgrep hyprpaper)

        # Setting Hyprland screens
        # "DP-1,1920x1080@144.00,0x0,1"
        # "DP-2,1920x1080@165.00,1920x0,1"
        # "DP-3,1920x1080,3840x0,1" ]
        # wlr-randr could be an alternative
        echo "Setting Full Monitor Mode ... "
        hyprctl reload

        echo "Setting Wallpapers"
        hyprpaper &
    '')
  ];
}
