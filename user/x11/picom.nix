{ ... }:

{
  # Picom Configuration for X11
  services.picom = {
    #enable = true;
    enable = false;
    vSync = false;
    backend = "glx";

    # Shadow
    shadow = true;
    shadowOpacity = 0.7;
    shadowExclude = [
      "name = 'Notification'"
      "class_g = 'Conky'"
      "class_g ?= 'Notify-osd'"
      "class_g = 'Cairo-clock'"
      "class_g = 'slop'"
      "_GTK_FRAME_EXTENTS@:c"
    ];

    # Fade
    fade = true;
    fadeSteps = [ 0.03 0.03 ];

    # Opacity
    activeOpacity = 1.0;
    inactiveOpacity = 0.8;
    opacityRules = [
      "80:class_g     = 'Bar'"
      "82:class_g    = 'Steam'"
      "97:class_g    = 'Emacs'"
      "92:class_g    = 'Alacritty'"
      "92:class_g    = 'kitty'"
      "92:class_g    = 'Nitrogen'"
      "92:class_g    = 'discord'"
      "92:class_g    = 'Exodus'"
      "92:class_g    = 'Binance'"
      "92:class_g    = 'VirtualBox Manager'"
      "92:class_g    = 'Virt-manager'"
      "92:class_g    = 'GParted'"
      "92:class_g    = 'Pavucontrol'"
      "92:class_g    = 'Pcmanfm'"
      "90:class_g    = 'qutebrowser'"
      "50:class_g     = 'Xfce4-notifyd'"
      "90:class_g     = 'Lxappearance'"
      "50:class_g     = 'dunst'"
      "80:class_g     = 'Spotify'"
      "85:class_g     = 'Signal'"
      "90:class_g     = 'Archlinux-tweak-tool.py'"
      "90:class_g     = 'Conky'"
      "90:class_g     = 'bottles'"
      "100:class_g    = 'firefox'"
      "100:class_g    = 'Brave-browser'"
      "82:class_g    = 'thunderbird'"
    ];

    # Additional Settings
    settings = {
      blur = {
        method = "gaussian";
        size = 10;
        deviation = 5.0;
      };
      round-borders = 1;
      corner-radius = 15.0;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      refresh-rate = 60;
    };
  };
}
