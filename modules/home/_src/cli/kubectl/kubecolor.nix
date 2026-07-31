{ config, ... }:

{
  # Kubecolor
  programs.kubecolor = {
    enable = true;
    enableAlias = true;
    settings = {
      preset = "dark";
      theme = {
        base = {
          info = "fg=#${config.colorScheme.palette.base05}";
          primary = "fg=#${config.colorScheme.palette.base0E}";
          secondary = "fg=#${config.colorScheme.palette.base0D}";
          success = "fg=#${config.colorScheme.palette.base0B}:bold";
          warning = "fg=#${config.colorScheme.palette.base0A}:bold";
          danger = "fg=#${config.colorScheme.palette.base08}:bold";
          muted = "fg=#${config.colorScheme.palette.base06}";
          key = "fg=#${config.colorScheme.palette.base07}:bold";
        };
        default = "fg=#${config.colorScheme.palette.base05}";
        data = {
          key = "fg=#${config.colorScheme.palette.base07}:bold";
          string = "fg=#${config.colorScheme.palette.base05}";
          "true" = "fg=#${config.colorScheme.palette.base0B}:bold";
          "false" = "fg=#${config.colorScheme.palette.base08}:bold";
          number = "fg=#${config.colorScheme.palette.base0E}";
          "null" = "fg=#${config.colorScheme.palette.base06}";
          quantity = "fg=#${config.colorScheme.palette.base0E}";
          duration = "fg=#${config.colorScheme.palette.base09}";
          durationfresh = "fg=#${config.colorScheme.palette.base0B}";
          ratio = {
            zero = "fg=#${config.colorScheme.palette.base06}";
            equal = "fg=#${config.colorScheme.palette.base0B}";
            unequal = "fg=#${config.colorScheme.palette.base0A}";
          };
        };
        status = {
          success = "fg=#${config.colorScheme.palette.base0B}:bold";
          warning = "fg=#${config.colorScheme.palette.base0A}:bold";
          error = "fg=#${config.colorScheme.palette.base08}:bold";
        };
        table = {
          header = "fg=#${config.colorScheme.palette.base0E}:bold";
          columns = "fg=#${config.colorScheme.palette.base05}";
        };
        stderr = {
          default = "fg=#${config.colorScheme.palette.base05}";
          error = "fg=#${config.colorScheme.palette.base08}:bold";
        };
        describe = {
          key = "fg=#${config.colorScheme.palette.base07}:bold";
        };
        apply = {
          created = "fg=#${config.colorScheme.palette.base0B}";
          configured = "fg=#${config.colorScheme.palette.base0A}";
          unchanged = "fg=#${config.colorScheme.palette.base05}";
          dryrun = "fg=#${config.colorScheme.palette.base0D}";
          fallback = "fg=#${config.colorScheme.palette.base05}";
        };
        explain = {
          key = "fg=#${config.colorScheme.palette.base07}:bold";
          required = "fg=#${config.colorScheme.palette.base00}:bold";
        };
        options = {
          flag = "fg=#${config.colorScheme.palette.base07}:bold";
        };
        version = {
          key = "fg=#${config.colorScheme.palette.base07}:bold";
        };
      };
    };
  };
}
