{ ... }:

{
  # Pyprland Plugins Configs
  home.file = {
    "pyprland.toml" = {
      enable = true;
      target = ".config/hypr/pyprland.toml";
      text = ''[pyprland]
plugins = ["scratchpads"]

[scratchpads.system_monitor]
animation = ""
command = "alacritty -T SysMon -e btm"
class = "sysmon"
position = "20% 3%"
size = "60% 30%"
multi = false
      '';
    };
  };
}
