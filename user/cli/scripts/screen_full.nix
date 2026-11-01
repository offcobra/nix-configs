{ pkgs, ... }:

{
  home.packages = [
    # ShellScript to set my Full Screen Layout
    # Hyprland uses a Lua config now, so `hyprctl keyword monitor` no longer
    # works. Monitors are set through `hyprctl eval` with `hl.monitor({...})`.
    # Enabled monitors need an explicit `disabled = false`, otherwise a previous
    # `disabled = true` sticks and the monitor stays off.
    (pkgs.writeShellScriptBin "screen-full.sh" /*bash*/ ''
      notify-send -t 5000 "Screen Mode" "Setting Screens to Full Mode..."

        # Setting Hyprland screens
        echo "Setting Full Monitor Mode ... "
        hyprctl eval 'hl.monitor({ output = "DP-1",     mode = "1920x1080@144.00", position = "0x0",    scale = 1, disabled = false })'
        hyprctl eval 'hl.monitor({ output = "HDMI-A-1", mode = "2560x1440@143.91", position = "1920x0", scale = 1, disabled = false })'
        hyprctl eval 'hl.monitor({ output = "DP-3",     mode = "1920x1080",        position = "4480x0", scale = 1, disabled = false })'
    '')
  ];
}
