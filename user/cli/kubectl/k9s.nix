{ config, ... }:

{
  # K9s Config
  programs.k9s = {
    enable = true;
    settings = {
      k9s = {
        ui = {
          headless = true;
          enableMouse = false;
          crumbsless = true;
          logoless = true;
          noIcons = false;
          skin = "default";
        };
        readOnly = false;
        refreshRate = 2;
        maxConnRetry = 5;
        noExitOnCtrlC = true;
        skipLatestRevCheck = false;
        logger = {
          tail = 102;
          buffer = 5020;
          sinceSeconds = 60;
          fullScreenLogs = false;
          textWrap = false;
          showTime = false;
        };
        thresholds = {
          cpu = {
            critical = 90;
            warn = 70;
          };
          memory = {
            critical = 90;
            warn = 70;
          };
        };
      };
    };
    skins = {
      default = {
        k9s = {
          body = {
            fgColor = "#${config.colorScheme.palette.base05}";
            bgColor = "#${config.colorScheme.palette.base02}";
            logoColor = "#${config.colorScheme.palette.base0E}";
          };
          prompt = {
            fgColor = "#${config.colorScheme.palette.base05}";
            bgColor = "#${config.colorScheme.palette.base01}";
            suggestColor = "#${config.colorScheme.palette.base0D}";
          };
          help = {
            fgColor = "#${config.colorScheme.palette.base05}";
            bgColor = "#${config.colorScheme.palette.base02}";
            sectionColor = "#${config.colorScheme.palette.base0B}";
            keyColor = "#${config.colorScheme.palette.base0D}";
            numKeyColor = "#${config.colorScheme.palette.base0A}";
          };
          frame = {
            title = {
              bgColor = "#${config.colorScheme.palette.base02}";
              fgColor = "#${config.colorScheme.palette.base05}";
            };
            border = {
              focusColor = "#${config.colorScheme.palette.base07}";
              fgColor = "#${config.colorScheme.palette.base05}";
            };
            crumbs = {
              bgColor = "#${config.colorScheme.palette.base02}";
              fgColor = "#${config.colorScheme.palette.base05}";
              activeColor = "#${config.colorScheme.palette.base05}";
            };
          };
          views = {
            table = {
              bgColor = "#${config.colorScheme.palette.base02}";
              fgColor = "#${config.colorScheme.palette.base05}";
              header = {
                bgColor = "#${config.colorScheme.palette.base02}";
                fgColor = "#${config.colorScheme.palette.base05}";
              };
            };
            xray = {
              bgColor = "#${config.colorScheme.palette.base02}";
              fgColor = "#${config.colorScheme.palette.base05}";
            };
            logs = {
              bgColor = "#${config.colorScheme.palette.base02}";
              fgColor = "#${config.colorScheme.palette.base05}";
              indicator = {
                bgColor = "#${config.colorScheme.palette.base02}";
              };
            };
            charts = {
              bgColor = "#${config.colorScheme.palette.base02}";
            };
          };
        };
      };
    };
  };
}
