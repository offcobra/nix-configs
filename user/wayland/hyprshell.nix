{ ...  }:

{
  services.hyprshell = {
    enable = true;
    systemd.enable = true;
    settings = {
      version = 1;
      layerrules = true;
      kill_bind = "ctrl+shift+alt, h";

      windows = {
        scale = 8.5;
        items_per_row = 5;

        switch = {
          modifier = "alt";
          filter_by = [];
          show_workspaces = false;
        };

        overview = {
          strip_html_from_workspace_title = true;
          key = "Tab";
          modifier = "super";
          filter_by = [];
          hide_filtered = false;

          launcher = {
            default_terminal = "foot";
            launch_modifier = "ctrl";
            width = 650;
            max_items = 5;
            show_when_empty = true;
            animate_launch_ms = 250;

            plugins.applications = {
              run_cache_weeks = 4;
              show_execs = true;
              show_actions_submenu = false;
            };
          };
        };
      };
    };
    style = "
:root {
    --border-color: rgba(90, 90, 120, 0.4);
    --border-color-active: rgba(239, 9, 9, 0.9);

    --bg-color: rgba(20, 20, 20, 0.9);
    --bg-color-hover: rgba(40, 40, 50, 1);

    --border-radius: 12px;
    --border-size: 3px;
    --border-style: solid;
    --border-style-secondary: dashed;

    --text-color: rgba(245, 245, 245, 1);

    --window-padding: 2px;
}

.window {
}


.monitor {
}

.workspace {
}

.client {
}

.client-image {
}


.launcher {
}

.launcher-input {
}

.launcher-results {
}

.launcher-item {
}

.launcher-exec {
}

.launcher-key {
}

.launcher-plugins {
}

.launcher-plugin {
}
    ";
  };
}
