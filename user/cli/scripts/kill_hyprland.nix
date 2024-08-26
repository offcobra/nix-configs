{ pkgs, ... }:

{
  home.packages = [
    # ShellScript to set my Work Screen Layout
    (pkgs.writeShellScriptBin "kill-hyprland.sh" /*bash*/ ''
    echo "### === --->>> Killing all Hyprland Apps..."
    apps=(waybar dunst hyprpaper emacs nm-applet copyq hypridle whatsapp signal watch_battery)
    for app in apps
    do
      echo "$app -> $(pgrep app)"
      kill -9 $(pgrep $app) &
    done
    hyprctl dispatch exit 0
    echo "### === --->>> Hyprland is dead..."
    '')
  ];
}
