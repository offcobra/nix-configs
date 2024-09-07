{ config, ... }:

{
  # Imv Image viewer
  programs.imv = {
    enable = true;
    settings = {
      options = {
        suppress_default_binds = true;
        overlay_font = "Firacodenerdfont:12";
        background = "${config.colorScheme.palette.base00}";
      };

      # Binds
      binds = {
        q = "quit";
        f = "fullscreen";
        c = "center";

        # Navigation
        h = "prev";
        l = "next";
        gg = "goto 1";
        "<Shift+G>" = "goto -1";

        # Rotate
        r = "reset";
        "<Ctrl+r>" = "rotate by 90";
      };
    };
  };
}
