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
    {
      "label" = "quit";
      "action" = "kill-hyprland.sh";
      "text" = "Quit Hyprland";
      "keybind" = "q";
    }
    ];
    style = ''
      * {
	    background-image: none;
      }
      window {
      	background-color: rgba(30, 30, 46, 0.8);
      }
      button {
        color: #${config.colorScheme.palette.base0D};
      	font-size: 16px;
      	background-color: #${config.colorScheme.palette.base00};
      	border-style: none;
      	background-repeat: no-repeat;
      	background-position: center;
      	background-size: 35%;
      	border-radius: 30px;
      	margin: 182px 5px;
      	text-shadow: 0px 0px;
      	box-shadow: 0px 0px;
      }

      button:focus, button:active, button:hover {
      	background-color: #${config.colorScheme.palette.base01};
      	outline-style: none;
      }

      #lock {
          background-image: image(url("/home/${userSettings.username}/.config/nixos/user/wayland/wlogout/icons/lock-v1.png"));
      }

      #logout {
          background-image: image(url("/home/${userSettings.username}/.config/nixos/user/wayland/wlogout/icons/logout-v1.png"));
      }

      #quit {
          background-image: image(url("/home/${userSettings.username}/.config/nixos/user/wayland/wlogout/icons/cancel-v1.png"));
      }

      #shutdown {
          background-image: image(url("/home/${userSettings.username}/.config/nixos/user/wayland/wlogout/icons/shutdown-v1.png"));
      }

      #reboot {
          background-image: image(url("/home/${userSettings.username}/.config/nixos/user/wayland/wlogout/icons/restart-v1.png"));
      }
    '';
  };
}
