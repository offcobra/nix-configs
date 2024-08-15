{ config, userSettings, ... }:

{
  # WLogout Config
  programs.wlogout = {
    enable = true;
    layout = [
    {
      "label" = "lock";
      "action" = "loginctl lock-session";
      "text" = "Lock";
      "keybind" = "l";
    }
    {
      "label" = "reboot";
      "action" = "systemctl reboot";
      "text" = "Reboot";
      "keybind" = "r";
    }
    {
      "label" = "shutdown";
      "action" = "systemctl poweroff";
      "text" = "Shutdown";
      "keybind" = "s";
    }
    {
      "label" = "logout";
      "action" = "hyprctl dispatch exit 0";
      "text" = "Logout";
      "keybind" = "x";
    }
    ];
    style = ''
      "$font = Firacodenerdfont:Semibold
      * {
        background-image: /home/${userSettings.username}/.config/nixos/user/wallpapers/nix.png;
      }

      window {
          font-family: $font
          font-size: 65pt;
          color: #${config.colorScheme.palette.base0D}; /* text */
          background-color: #${config.colorScheme.palette.base00};
      }

      button {
          color: #${config.colorScheme.palette.base05}; /*  text / nerdfont */
            background-color: #${config.colorScheme.palette.base01};
            border-style: solid;
            border-width: 3px;
            margin: 10px;
            border-radius: 10px;
            background-position: center;
          border-color: black;
            text-decoration-color: #FFFFFF;
          transition: box-shadow 0.2s ease-in-out, background-color 0.2s ease-in-out;
      }

      button:focus, button:active, button:hover {
          background-color: #${config.colorScheme.palette.base02};
          outline-style: none;
      }

      #lock {
      }

      #logout {
      }

      #suspend {
      }

      #hibernate {
      }

      #shutdown {
      }

      #reboot {
      }

    '';
  };
}
