{ config, userSettings, systemSettings, ... }:

let
  font_size = if (systemSettings.hostname == "thinkpad") then "10" else "9";
in
{
  # Configure dunst notify
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "mouse";
        geometry = "80x50-20+50";
        indicate_hidden = "no";
        shrink = "no";
        separator_height = 4;
        separator_color = "yes";
        padding = 15;
        horizontal_padding = 15;
        frame_width = 3;
        sort = "no";
        idle_threshold = 40;
        font = "${userSettings.font} ${font_size}";
        line_height = 4;
        markup = "full";
        format = "<b>%s</b>\n%b";
        alignment = "left";
        show_age_threshold = 60;
        word_wrap = "yes";
        ignore_newline = "no";
        stack_duplicates = "false";
        hide_duplicate_count = "yes";
        show_indicators = "no";
        icon_position = "left";
        max_icon_size = 48;
        sticky_history = "yes";
        history_length = 20;
        browser = "x-www-browser -new-tab";
        always_run_script = "true";
        title = "Dunst";
        class = "Dunst";
        corner_radius = 10;
        origin = "top-right";
        offset = "8x10";
      };

      shortcuts = {
        close = "ctrl+shift+space";
        close_all = "ctrl+shift+space";
        history = "ctrl+grave";
        context = "ctrl+shift+period";
      };

      urgency_low = {
        timeout = 4;
        background = "#${config.colorScheme.palette.base0C}aa";
        foreground = "#${config.colorScheme.palette.base02}";
        frame_color = "#${config.colorScheme.palette.base00}ee";
      };

      urgency_normal = {
        timeout = 8;
        background = "#${config.colorScheme.palette.base05}aa";
        foreground = "#${config.colorScheme.palette.base02}";
        frame_color = "#${config.colorScheme.palette.base00}ee";
      };

      urgency_critical = {
        timeout = 0;
        background = "#${config.colorScheme.palette.base09}aa";
        foreground = "#${config.colorScheme.palette.base02}";
        frame_color = "#${config.colorScheme.palette.base00}ee";
      };
    };
  };
}
