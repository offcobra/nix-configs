{ config, userSettings, ... }:

let
   background = "${config.colorScheme.palette.base00}";
   foreground = "${config.colorScheme.palette.base05}";
   active = "${config.colorScheme.palette.base0E}";
   inactive = "${config.colorScheme.palette.base09}";
   color1 = "${config.colorScheme.palette.base06}";
   color2 = "${config.colorScheme.palette.base09}";
   color3 = "${config.colorScheme.palette.base0C}";
   color4 = "${config.colorScheme.palette.base0D}";
in
{
  # Hyprlock Configs
  # TODO
  programs.ashell = {
    enable = true;
    systemd.enable = true;
    settings = {
      position = "Top";
      app_launcher_cmd = "fuzzel";
      outputs = {
        Targets = [ "DP-1" "eDP-1" ];
      };
      modules = {
        center = [
          "Window Title"
        ];
        left = [
          "Workspaces"
        ];
        right = [
          "SystemInfo"
          [
            "Clock,"
            "Privacy"
            "Settings"
          ]
        ];
      };
      workspaces = {
        visibilityMode = "MonitorSpecific";
      };
      appearance = {
        font = "${userSettings.font}:Semibold:size=8";
        scale_factor = 1;
        style = "Gradient";
        success_color = "#a6e3a1";
        text_color = "#cdd6f4";

        workspace_colors = [ "#fab387" "#b4befe" "#cba6f7" ];
        primary_colors = {
          base = "#fab387";
          text = "#1e1e2e";
        };
        danger_colors = {
          base = "#f38ba8";
          text = "#f9e2af";
        };
        background_colors = {
          base = "#1e1e2e";
          text = "#313244";
          strong = "#45475a";
        };
        secondary_colors = {
          base = "#11111b";
          strong = "#1b1b25";
        };
      };
    };
  };
}
