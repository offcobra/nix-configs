{ pkgs, ... }:

{
  home.packages = [
    # ShellScript to kill Hyprland
    (pkgs.writeShellScriptBin "kill-wm.sh" /*bash*/ ''

      echo "### === --->>> Killing all Window Manager Apps..."

      if [[ $XDG_SESSION_TYPE == "wayland" ]]
      then
        apps=(waybar dunst hyprpaper emacs nm-applet copyq hypridle zapzap signal watch_battery)
        session=Hyprland
      else
        apps=(dunst emacs nm-applet copyq zapzap signal watch_battery blueberry flameshot)
        session=qtile
      fi

      notify-send -t 2000 "Session-Manager" "Killing $session & Apps..."

      for app in apps
      do
        echo "$app -> $(pgrep app)"
        kill -9 $(pgrep $app) &
      done

      kill -9 $(pgrep $session)

      echo "### === --->>> Hyprland is dead..."
    '')
  ];
}
