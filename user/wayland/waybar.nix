{ config, pkgs, ... }:

{
  # Waybar Config
  programs.waybar = {
    enable = true;
    settings = [{
        layer= "top";
          modules-left = ["custom/arch" "hyprland/workspaces" "hyprland/window"];
          modules-center = ["custom/temp" "cpu" "custom/cpu" "memory"];
          modules-right = ["custom/virtual" "custom/vpn" "pulseaudio" "clock" "tray"];
          height= 8;
          "custom/arch" = {
            format = "";
            tooltip = false;
            on-click = "alacritty --hold -e bat $HOME/.config/docs/shortcuts.org";
          };
          "hyprland/workspaces"= {
            format = "{icon}";
            on-click = "activate";
            tooltip = false;
            all-outputs = true;
            format-icons = {
                   "1" = "";
                   "2" = "";
                   "3" = "";
                   "4" = "󰣭";
                   "5" = "";
                   "6" = "";
                   "7" = "";
                   "urgent" = "";
                   "focused" = "";
                   "default" = "";
            };
          };
          "hyprland/window"= {
              format = "{title}";
              max-length = 50;
              rewrite = {
                  "(.*) GNU Emacs (.*)"= "  $1";
                  "(.*) Mozilla Firefox"= "  $1";
                  "(.*) LibreWolf"= "  $1";
                  "(.*) - Brave"= "  $1";
                  "Alacritty"= "  $2";
                  "(.*) - bash"= " $1";
                  "(.*) - Discord"= "󰙯 $1";
                  "(.*) - Spotify"= " $1";
                  "(.*) - Steam"= " $1";
                  "(.*) - Signal"= " $1";
                  "(.*) - Thorium"= "  $1";
                  "(.*) - Whatsapp"= " $1";
                  "apps"= " Apps Container";
                  "blackarch"= "  Blackarch";
                  "ubuntu"= "  Ubuntu";
                  "debian"= "  Debian";
                  "opensuse"= "  OpenSUSE";
                  "fedora"= "  Fedora";
                  "parrot"= "  ParrotOS";
                  "Wdgfdsgfs"= "    󱄲        ";
              };
          };
          #"custom/virtual" = {
          #    exec= "~/.config/waybar/scripts/get_virtual";
          #    restart-interval = 1;
          #};
          #"custom/vpn" = {
          #    exec = "~/.config/waybar/scripts/get_vpn";
          #    on-click = "toggle_vpn";
          #    restart-interval = 5;
          #};
          "custom/temp" = {
              on-click = "alacritty --hold -e sensors";
              restart-interval = 1;
              exec = pkgs.writeShellScript "get_temp" ''
                STATUS=$(sensors | grep -i "cpu" | cut -d : -f 2 | xargs)
                echo " $STATUS"
              '';
          };
          "custom/cpu" = {
              #on-click = "toggle_cpu";
              restart-interval = 1;
              exec = pkgs.writeShellScript "get_cpu_guvernor" ''
                STATUS=$(/run/current-system/sw/bin/cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
                echo "  => $STATUS"
              '';
          };
          "cpu" = {
              format = " {usage: >3}%";
              on-click = "alacritty -e btm";
          };
          "memory" = {
              format = " {: >3}%";
              on-click = "alacritty -e btm";
          };
          "clock" = {
            "format"= "  {:%a %d %b  %H:%M}";
            on-click = "alacritty --hold -e cal";
          };
          "pulseaudio" = {
            format = "{icon} {volume}%";
            format-muted = "";
            tooltip = false;
            format-icons = {
              "headphone"= "";
              "default"= ["" "" "󰕾" "󰕾" "󰕾" "" "" ""];
            };
            scroll-step = 1;
          };
          "tray" = {
              icon-size = 10;
              spacing = 5;
          };
    }];
    style = ''
      @define-color background #${config.colorScheme.palette.base00};
      @define-color foreground #${config.colorScheme.palette.base05};
      @define-color active #${config.colorScheme.palette.base0E};
      @define-color inactive #${config.colorScheme.palette.base09};
      @define-color color1 #${config.colorScheme.palette.base06};
      @define-color color2 #${config.colorScheme.palette.base09};
      @define-color color3 #${config.colorScheme.palette.base0C};
      @define-color color4 #${config.colorScheme.palette.base0D};
      * {
        border: none;
        font-family: 'Firacodenerdfont';
        font-size: 9px;
        font-weight: bold;
        font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
        min-height: 12px;
      }
      
      window#waybar {
        background: transparent;
      }
      
      #custom-arch {
        border-radius: 10px;
        background-color: @background;
        color: @inactive;
        font-size: 12px;
        margin-top: 2px;
        margin-right: 5px;
        margin-left: 5px;
        padding-top: 1px;
        padding-left: 10px;
        padding-right: 14px;
      
      }
      
      #workspaces {
        border-radius: 10px;
        background-color: @background;
        color: @foreground;
        font-size: 13px;
        margin-top: 2px;
        margin-right: 5px;
        padding-top: 1px;
        padding-left: 6px;
        padding-right: 6px;
      
      }
      
      #custom-cpu, #custom-temp, #custom-vpn, #custom-virtual,  #window {
        border-radius: 10px;
        background-color: @background;
        color: @foreground;
        margin-top: 2px;
        margin-right: 5px;
        padding-top: 1px;
        padding-left: 10px;
        padding-right: 10px;
      }
      
      #workspaces button {
        background: @background;
        color: @active;
      }
      
      #workspaces button.active {
        background: @background;
        color: @inactive;
      }
      
      window#waybar.empty #window {
        padding: 0px;
        margin: 0px;
        border: 0px;
        background-color: transparent;
      }
      
      #clock, #temperature, #pulseaudio, #cpu, #network, #memory, #tray{
        border-radius: 10px;
        background-color: @background;
        color: @color1;
        margin-top: 2px;
        padding-left: 10px;
        padding-right: 10px;
        margin-right: 5px;
      }
      
      #window{
        color: @color1;
      }
      
      #clock, #custom-temp{
        color: @color1;
      }
      
      #cpu{
        color: @color3;
      }
      
      #memory, #pulseaudio{
        color: @color4;
      }
      
      #custom-cpu{
        color: @color2;
      }

    ''; 
  };
}

