{ config, userSettings, ... }:

{
  #programs.waybar.style = ''
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
      font-family: '${userSettings.font}';
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
      color: @active;
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
      margin-left: 5px;
      padding-top: 1px;
      padding-left: 6px;
      padding-right: 6px;

    }

    #custom-temp, #custom-vpn, #custom-cpu, #custom-virtual,  #window, #idle_inhibitor {
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
      color: @inactive;
    }

    #workspaces button.active {
      background: @background;
      color: @active;
    }

    window#waybar.empty #window {
      padding: 0px;
      margin: 0px;
      border: 0px;
      background-color: transparent;
    }

    #clock, #temperature, #pulseaudio, #cpu, #network, #memory, #tray, #battery{
      border-radius: 10px;
      background-color: @background;
      color: @inactive;
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

    #cpu, #battery{
      color: @color3;
    }

    #memory, #pulseaudio{
      color: @color4;
    }

    #custom-cpu{
      color: @color2;
    }
  '';
}
