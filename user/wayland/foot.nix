{ config, ... }:

{
  # Foot Terminal
  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "2x2";
        font = "Firacodenerdfont:Semibold:size=8";
      };
      scrollback.lines = 5000;
      colors = {
        foreground = "${config.colorScheme.palette.base05}"; # Text
        background = "${config.colorScheme.palette.base00}"; # Base
        regular0 = "${config.colorScheme.palette.base02}";   # Surface 1
        regular1 = "${config.colorScheme.palette.base06}";   # red
        regular2 = "${config.colorScheme.palette.base0B}";   # green
        regular3 = "${config.colorScheme.palette.base09}";   # yellow
        regular4 = "${config.colorScheme.palette.base0D}";   # blue
        regular5 = "${config.colorScheme.palette.base0E}";   # pink
        regular6 = "${config.colorScheme.palette.base0C}";   # teal
        regular7 = "${config.colorScheme.palette.base03}";   # Subtext 1
        bright0 = "${config.colorScheme.palette.base04}";    # Surface 2
      };
    };
  };
}
