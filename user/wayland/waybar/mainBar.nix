{ pkgs, systemSettings, ...}:

let
  temp = if (systemSettings.hostname == "workstation")
    then
      "tctl"
    else if (systemSettings.hostname == "thinkpad")
    then
      "cpu"
    else
      "temp1";
  moduleCenter = if (systemSettings.hostname == "mediatv")
    then
      ["custom/temp" "cpu" "custom/cpu" "memory" ]
    else if (systemSettings.hostname == "thinkpad")
    then
      ["custom/temp" "cpu" "custom/cpu" "memory" "battery" "custom/virtual"]
    else
      ["custom/temp" "cpu"  "custom/cpu" "memory" "custom/virtual"];
  output = if (systemSettings.hostname == "workstation")
    then
      "DP-1"
    else
      "";
  worskspace = {
    format = "{icon}";
    on-click = "activate";
    tooltip = false;
    all-outputs = true;
    icon-size = 26;
    format-icons = {
      "1" = "";
      "2" = "";
      "3" = "";
      "4" = "󰣭";
      "5" = "";
      "6" = "";
      "7" = "";
      "8" = "";
      "9" = "";
      "urgent" = " #=->   <-=# ";
      "focused" = "";
      "default" = "";
    };
  };
  window = {
    format = "{initialTitle} - {title}";
    max-length = 50;
    separate-outputs = true;
    rewrite = {
      "(.*) GNU Emacs (.*)"= "  $1";
      "(.*) Mozilla Firefox"= "  $1";
      "(.*) LibreWolf"= "  $1";
      "(.*) - bash"= "  $1";
      #New------------------------------
      "(.*) - Brave - (.*) - Brave"= "  $2";
      "Alacritty - (.*)"= "   $1";
      "foot - (.*)"= "   $1";
      "Ollama - (.*)"= "󰧑  $1 AI Chat";
      "(.*) - Freetube"= "  $1";
      "(.*) - Spotify Premium"= "  $1";
      "Spotify Premium - (.*)"= "  $1";
      "NeoVim - NeoVim"= " -> Doing stuff right...";
      "Signal - (.*)"= "󱋑  $1";
      "ZapZap - (.*)"= "  $1";
      "Bitwarden - (.*)"= "󰞀  $1";
      "(.*) - Looking Glass(.*)"= "󰖳 Windows Gaming...";
      "(.*) - Steam"= "  $1";
      "(.*) - Discord - (.*)"= "󰙯  $1";
      "(.*) - WebCord - (.*)"= "  $1";
      #---------------------------------
      "(.*) - Thorium - (.*)"= "  $2";
      "apps"= " Apps Container";
      "blackarch - (.*)"= "  Blackarch";
      "ubuntu - (.*)"= "󰕈  Ubuntu";
      "arch - (.*)"= "  ArchLinux";
      "debian - (.*)"= "  Debian";
      "opensuse - (.*)"= "  OpenSUSE";
      "fedora - (.*)"= "  Fedora";
      "parrot - (.*)"= "  ParrotOS";
      "(.*) - Virtual Machine Manager"= "󰖳         - Vm's Manager";
    };
  };
  clock = {
    format = "  {:%H:%M  %a %d %b }";
    on-click = "alacritty --hold -e dcal";
  };
in
{
  mainBar = {
    layer= "top";
    output = output;
    modules-left = ["hyprland/workspaces" "hyprland/window"];
    modules-center = moduleCenter;
    modules-right = ["idle_inhibitor" "pulseaudio" "tray" "clock"];
    height= 8;
    "custom/arch" = {
      format = "";
      tooltip = false;
      on-click = "alacritty --hold -e bat $HOME/.config/docs/shortcuts.org";
    };
    "hyprland/workspaces"= worskspace;
    "hyprland/window"= window;
    "idle_inhibitor" = {
        "format" = "{icon}";
        "format-icons" = {
          "activated" = "󰒳";
          "deactivated" = "󰒲";
        };
    };
    "custom/virtual" = {
        restart-interval = 2;
        exec = "virt-run.py --info";
    };
    #"custom/vpn" = {
    #    exec = "~/.config/waybar/scripts/get_vpn";
    #    on-click = "toggle_vpn";
    #    restart-interval = 5;
    #};
    "custom/temp" = {
        on-click = "alacritty --hold -e sensors";
        restart-interval = 1;
        exec = pkgs.writeShellScript "get_temp" ''
          STATUS=$(sensors | grep -i ${temp} | cut -d : -f 2 | xargs)
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
    "battery" = {
      "states" = {
    	  "warning" = 30;
        "critical" = 15;
      };
      "format" = "{icon}  {capacity}%";
      "format-charging" = "󱐋  {capacity}%";
      "format-plugged" = "  {capacity}%";
      "format-alt" = "󰥔  {time} {icon}";
      "format-full" = "  {capacity}%";
      "format-icons" = ["" "" ""];
    };
    "memory" = {
      format = " {: >3}%";
      on-click = "alacritty -e btm";
    };
    "clock" = clock;
    "pulseaudio" = {
      format = "{icon} {volume}%";
      format-muted = "";
      tooltip = false;
      format-icons = {
        "headphone"= "";
        "default"= ["" "" "󰕾" "󰕾" "󰕾" "" "" ""];
      };
      scroll-step = 5;
    };
    "tray" = {
      icon-size = 10;
      spacing = 5;
    };
  };
  secondBar = {
    layer= "top";
    output = [ "DP-2" "DP-3" ];
    modules-left = ["hyprland/workspaces" "hyprland/window"];
    modules-right = [ "clock" ];
    height= 6;
    "hyprland/workspaces"= worskspace;
    "hyprland/window"= window;
    "clock" = clock;
  };
}
