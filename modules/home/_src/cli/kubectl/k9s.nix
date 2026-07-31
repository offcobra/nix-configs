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
            bgColor = "#${config.colorScheme.palette.base00}";
            logoColor = "#${config.colorScheme.palette.base0E}";
          };
          prompt = {
            fgColor = "#${config.colorScheme.palette.base05}";
            bgColor = "#${config.colorScheme.palette.base00}";
            suggestColor = "#${config.colorScheme.palette.base0D}";
          };
          help = {
            fgColor = "#${config.colorScheme.palette.base05}";
            bgColor = "#${config.colorScheme.palette.base00}";
            sectionColor = "#${config.colorScheme.palette.base0B}";
            keyColor = "#${config.colorScheme.palette.base0D}";
            numKeyColor = "#${config.colorScheme.palette.base0A}";
          };
          frame = {
            title = {
              bgColor = "#${config.colorScheme.palette.base00}";
              fgColor = "#${config.colorScheme.palette.base05}";
              highlightColor = "#${config.colorScheme.palette.base06}";
              counterColor = "#${config.colorScheme.palette.base0A}";
              filterColor = "#${config.colorScheme.palette.base0B}";
            };
            border = {
              focusColor = "#${config.colorScheme.palette.base07}";
              fgColor = "#${config.colorScheme.palette.base05}";
            };
            menu = {
              fgColor = "#${config.colorScheme.palette.base05}";
              keyColor = "#${config.colorScheme.palette.base0D}";
              numKeyColor = "#${config.colorScheme.palette.base08}";
            };
            crumbs = {
              bgColor = "#${config.colorScheme.palette.base00}";
              fgColor = "#${config.colorScheme.palette.base05}";
              activeColor = "#${config.colorScheme.palette.base05}";
            };
            status = {
              newColor = "#${config.colorScheme.palette.base0D}";
              modifyColor = "#${config.colorScheme.palette.base07}";
              addColor = "#${config.colorScheme.palette.base0B}";
              pendingColor = "#${config.colorScheme.palette.base09}";
              errorColor = "#${config.colorScheme.palette.base08}";
              highlightColor = "#${config.colorScheme.palette.base0C}";
              killColor = "#${config.colorScheme.palette.base0E}";
              completedColor = "#${config.colorScheme.palette.base04}";
            };
          };
          info = {
            fgColor = "#${config.colorScheme.palette.base09}";
            sectionColor = "#${config.colorScheme.palette.base05}";
          };
          views = {
            table = {
              bgColor = "#${config.colorScheme.palette.base00}";
              fgColor = "#${config.colorScheme.palette.base05}";
              cursorFgColor = "#${config.colorScheme.palette.base02}";
              cursorBgColor = "#${config.colorScheme.palette.base03}";
              markColor = "#${config.colorScheme.palette.base06}";
              header = {
                bgColor = "#${config.colorScheme.palette.base00}";
                fgColor = "#${config.colorScheme.palette.base05}";
                sorterColor = "#${config.colorScheme.palette.base0C}";
              };
            };
            xray = {
              bgColor = "#${config.colorScheme.palette.base00}";
              fgColor = "#${config.colorScheme.palette.base05}";
              cursorColor = "#${config.colorScheme.palette.base03}";
              cursorTextColor = "#${config.colorScheme.palette.base00}";
              graphicColor = "#${config.colorScheme.palette.base06}";
            };
            yaml = {
              keyColor = "#${config.colorScheme.palette.base0D}";
              valueColor = "#${config.colorScheme.palette.base05}";
              colonColor = "#${config.colorScheme.palette.base04}";
            };
            logs = {
              bgColor = "#${config.colorScheme.palette.base00}";
              fgColor = "#${config.colorScheme.palette.base05}";
              indicator = {
                bgColor = "#${config.colorScheme.palette.base02}";
                fgColor = "#${config.colorScheme.palette.base07}";
                toggleOnColor = "#${config.colorScheme.palette.base0B}";
                toggleOffColor = "#${config.colorScheme.palette.base04}";
              };
            };
            charts = {
              bgColor = "#${config.colorScheme.palette.base00}";
            };
          };
          dialog = {
            fgColor = "#${config.colorScheme.palette.base0A}";
            bgColor = "#${config.colorScheme.palette.base00}";
            buttonFgColor = "#${config.colorScheme.palette.base00}";
            buttonBgColor = "#${config.colorScheme.palette.base02}";
            buttonFocusFgColor = "#${config.colorScheme.palette.base00}";
            buttonFocusBgColor = "#${config.colorScheme.palette.base06}";
            labelFgColor = "#${config.colorScheme.palette.base06}";
            fieldFgColor = "#${config.colorScheme.palette.base05}";
          };
        };
      };
    };
  };
}
