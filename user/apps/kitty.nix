{ config, userSettings, ... }:

{
  # Kitty Terminal
  programs.kitty = {
    enable = true;
    #font = {
    #  name = "${userSettings.font}:Semibold";
    #  size = 9;
    #};
    shellIntegration = {
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
    settings = {
      shell = "bash";
      window_padding_width = 2;
      placement_strategy = "top-left";
      scrollback_lines = 10000;
      show_hyperlink_targets = "yes";
      enable_audio_bell = false;
      url_style = "none";
      underline_hyperlinks = "never";
      copy_on_select = "clipboard";
      confirm_os_window_close = 0;
    };
    extraConfig = "
# Font Config
font_size 8.5
font_family      ${userSettings.font} Semibold
bold_font        ${userSettings.font} Bold
italic_font      ${userSettings.font} Italic
bold_italic_font ${userSettings.font} Bold Italic

# Color Config
# The basic colors
background              #${config.colorScheme.palette.base00}
foreground              #${config.colorScheme.palette.base05}
selection_background    #${config.colorScheme.palette.base06}
selection_foreground    #${config.colorScheme.palette.base01}

# Cursor colors
cursor                  #${config.colorScheme.palette.base06}
cursor_text_color       #${config.colorScheme.palette.base02}

# URL underline color when hovering with mouse
url_color               #${config.colorScheme.palette.base0B}

# black
color0 #${config.colorScheme.palette.base04}
color8 #${config.colorScheme.palette.base04}

# red
color1 #${config.colorScheme.palette.base08}
color9 #${config.colorScheme.palette.base08}

# green
color2  #${config.colorScheme.palette.base0B}
color10 #${config.colorScheme.palette.base0B}

# yellow
color3  #${config.colorScheme.palette.base0A}
color11 #${config.colorScheme.palette.base0A}

# blue
color4  #${config.colorScheme.palette.base0D}
color12 #${config.colorScheme.palette.base0D}

# magenta
color5  #${config.colorScheme.palette.base0C}
color13 #${config.colorScheme.palette.base0C}

# cyan
color6  #${config.colorScheme.palette.base0E}
color14 #${config.colorScheme.palette.base0E}

# white
color7  #${config.colorScheme.palette.base06}
color15 #${config.colorScheme.palette.base06}
    ";
  };
}
