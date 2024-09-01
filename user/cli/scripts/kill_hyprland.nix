{ pkgs, ... }:

{
  home.packages = [
    # ShellScript to kill Hyprland
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

    # ShellScript to kill Qtile
    (pkgs.writeShellScriptBin "kill-qtile.sh" /*bash*/ ''
      echo "### === --->>> Killing all Qtile Apps..."
      apps=(dunst emacs nm-applet copyq whatsapp signal watch_battery blueberry flameshot)
      for app in apps
      do
        echo "$app -> $(pgrep app)"
        kill -9 $(pgrep $app) &
      done
      kill -9 $(pgrep qtile)
      echo "### === --->>> Qtile is dead..."
    '')
  ];
}
