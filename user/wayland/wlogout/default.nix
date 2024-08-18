{ userSettings, ... }:

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
      "label" = "cancel";
      "action" = "kill -9 $(pgrep wlogout)";
      "text" = "Cancel";
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
        color: #0f2137;
      	font-size: 16px;
      	background-color: #5b6078;
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
      	background-color: #b9b1e2;
      	outline-style: none;
      }

      #lock {
          background-image: image(url("/home/${userSettings.username}/.config/nixos/user/wayland/wlogout/icons/lock-v1.png"));
      }

      #logout {
          background-image: image(url("/home/${userSettings.username}/.config/nixos/user/wayland/wlogout/icons/logout-v1.png"));
      }

      #cancel {
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
