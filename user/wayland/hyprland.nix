{ pkgs, systemSettings, userSettings, ... }:

let
  startup = pkgs.pkgs.writeShellScriptBin "hypr-startup" /*bash*/ ''
    if [[ ${systemSettings.hostname} == "mediatv" ]]
    then
      # Setting Screens MediaTV
      wlr-randr --output eDP-1 --off --output HDMI-A-1 --mode 1920x1080@60.00
    fi

    echo "Starting Dunst..."
    dunst &

    echo "Starting HyperPaper..."
    hyprpaper &

    echo "Starting Emacs..."
    emacs --daemon &

    echo "Starting NM-Applet..."
    nm-applet &

    echo "Starting HyprIdle..."
    hypridle &

    echo "Starting copyq Clipboard..."
    copyq --start-server &

    if [[ ${systemSettings.hostname} == "workstation" ]]
    then
      echo "Starting Waybar..."
      waybar &

      echo "Starting Signal & WhatsApp..."
      flatpak run org.signal.Signal --start-in-tray &
      flatpak run io.github.mimbrero.WhatsAppDesktop --start-hidden &

    elif [[ ${systemSettings.hostname} == "thinkpad" ]]
    then
      # Get Battery Notificaions
      watch_battery &
    fi
  '';
in
{
  imports =
    [ # Include other modules
      # HyprPaper
      ./hyprpaper.nix
      # Waybar
      ./waybar.nix
      # Terminals
      ./foot.nix
      # Launcher
      ./fuzzel.nix
      # Hyprlock
      ./hyprlock.nix
      # Hypridle
      ./hypridle.nix
      # Wlogout
      ./wlogout
    ];

  home.packages = with pkgs; [
    # Screenshot tools
    grim
    slurp
  ];

  # Window Manager
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = { enable = true; };
    systemd.enable = true;
    systemd.variables = [ "--all" ];
    plugins = [
      #inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
      #inputs.hyprland-plugins.packages.${pkgs.system}.hyprtrails
      #inputs.hyprland-plugins.packages.${pkgs.system}.hyprwrap
      #inputs.hyprland-plugins.packages.${pkgs.system}.csgo-vulkan-fix
    ];
    settings = {
      # Monitor settings
      monitor = if (systemSettings.hostname == "workstation")
                then
                  [ "DP-1,1920x1080@144.00,0x0,1"
                    "DP-2,1920x1080@165.00,1920x0,1"
                    "DP-3,1920x1080,3840x0,1" ]
                else if (systemSettings.hostname == "thinkpad")
                then
                  [ "eDP-1,1920x1080,0x0,1" ]
                else
                  [ "HDMI-A-1,1920x1080@60.00,0x0,1" ];

      # Recomended Hypr Cursor settings for nvidia
      cursor = if (systemSettings.hostname == "mediatv")
                then
                  { no_hardware_cursors = true; }
                else
                  { no_hardware_cursors = false; };

      # Testing GPU
      env = if (systemSettings.hostname == "mediatv")
            then
              "AQ_DRM_DEVICES,/dev/dri/card1:/dev/dri/card2"
            else
              "TEST,testing";

      # Input Settings
      input = {
        kb_layout = "de";
        follow_mouse = 1;
        scroll_factor = 1.3;

        touchpad = {
            natural_scroll = "no";
        };

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
        accel_profile = "flat";
      };

      # General Settings
      general = {
        gaps_in = 5;
        gaps_out = 5;
        layout = "master";
        border_size = 1;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
      };

      # Startup Programms
      exec-once = ''${startup}/bin/hypr-startup'';

      # Decorations
      decoration = {
        rounding = 10;

        blur = {
    	    enabled = false;
        };

        drop_shadow = "false";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      # Animations
      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      master = {
        new_on_top = "true";
        new_status = "master";
      };

      gestures = {
        workspace_swipe = "off";
      };

      # Bind Keyboard Settings
      "$mainMod" = "SUPER";
      bind = [
        # Terminals
        "$mainMod, return, exec, alacritty"
        "CTRL, return, exec, foot"

        # Clipboard manager
        "CTRL, P, exec, copyq show"

        # Ollama AI Chat
        "$mainMod, o, exec, alacritty --class ollama --title Ollama -e ollama run llama3.1"
        "$mainMod_SHIFT, return, exec, bash /home/${userSettings.username}/.local/bin/container_run arch"

        # Screenshot
        "$mainMod, x, exec, grim -g \"$(slurp -d)\""

        # WLogout
        "$mainMod, z, exec, wlogout --protocol layer-shell -b 5"

        # Window Actions
        #"CTRL, Space, fullscreenstate"
        "$mainMod, Q, killactive"
        "$mainMod_SHIFT, Q, exit"
        #"$mainMod_SHIFT, R, hyprctl reload"
        "$mainMod_SHIFT, F, togglefloating"
        "$mainMod_CTRL, F, fullscreen"
        "$mainMod_CTRL , L, exec, hyprlock"
        "$mainMod_SHIFT, B, exec, toggle_proc waybar"

        # Quick Shortcuts
        "$mainMod, P, exec, fuzzel"
        "$mainMod_SHIFT, P, exec, websearch.py"
        "$mainMod, F, exec, pcmanfm"
        "$mainMod, S, exec, alacritty -e btm"

        # Move focus with mainMod + arrow keys
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        # Move focus with mainMod + arrow keys
        "$mainMod_SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"

        # Resize
        "SUPERALT, H, resizeactive, -30 0"
        "SUPERALT, L, resizeactive, 30 0"
        "SUPERALT, K, resizeactive, 0 -30"
        "SUPERALT, J, resizeactive, 0 30"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Sound controls
        ", xf86audioraisevolume, exec, amixer sset Master 5%+"
        ", xf86audiolowervolume, exec, amixer sset Master 5%-"
        ", xf86audiomute, exec, amixer sset Master 0"
        ", xf86Messenger, exec, show_info"

        # Brightness controls
        ", xf86MonBrightnessDown, exec, light -U 5"
        ", xf86MonBrightnessUp, exec, light -A 5"
      ];
    };
    extraConfig = ''
      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = SUPER, mouse:272, movewindow
      bindm = SUPER, mouse:273, resizewindow

      # Defining SUBMAPS
      # BROWSERS
      bind = SUPER, B, submap, browsers
      submap = browsers
      bind = ,B, exec, brave
      bind = ,B, submap, reset
      bind = ,I, exec, brave --incognito
      bind = ,I, submap, reset
      bind = ,L, exec, docker_exec librewolf
      bind = ,L, submap, reset
      bind = ,T, exec, docker_exec thorium-browser
      bind = ,T, submap, reset
      bind = ,P, exec, docker_exec librewolf --private-window
      bind = ,P, submap, reset
      bind = ,F, exec, docker_exec firefox
      bind = ,F, submap, reset
      bind = ,H, exec, docker_exec thorium-browser --incognito
      bind = ,H, submap, reset
      bind = ,O, exec, qutebrowser -C /home/${userSettings.username}/.config/qutebrowser/config.py
      bind = ,O, submap, reset
      submap = reset

      # EMACS
      bind = SUPER, E, submap, emacs
      submap = emacs
      bind = ,N, exec, foot -T NeoVim -e nvim
      bind = ,N, submap, reset
      bind = ,O, exec, obsidian
      bind = ,O, submap, reset
      bind = ,E, exec, emacsclient -c -a 'emacs'
      bind = ,E, submap, reset
      bind = ,B, exec, emacsclient -c -a 'emacs' --eval '(ibuffer)'
      bind = ,B, submap, reset
      bind = ,R, exec, emacsclient -c -a 'emacs' --eval '((lambda () (interactive) (load-file "~/.config/emacs/init.el") (ignore (elpaca-process-queues))) :wk "Reload emacs config")'
      bind = ,R, submap, reset
      bind = ,D, exec, emacsclient -c -a 'emacs' --eval '(dired nil)'
      bind = ,D, submap, reset
      bind = ,T, exec, emacsclient -c -a 'emacs' --eval '(+vterm/here nil)'
      bind = ,T, submap, reset
      submap = reset

      # PROGRAMMS
      bind = SUPER, G, submap, programms
      submap = programms
      #bind = ,G, exec, flatpak run com.valvesoftware.Steam
      bind = ,G, exec, steam
      bind = ,G, submap, reset
      bind = ,V, exec, pavucontrol
      bind = ,V, submap, reset
      bind = ,F, exec, flatpak run com.github.tchx84.Flatseal
      bind = ,F, submap, reset
      bind = ,N, submap, reset
      bind = ,S, exec, spotify --enable-features=UseOzonePlatform --ozone-platform=wayland
      bind = ,S, submap, reset
      bind = ,E, exec, thunderbird
      bind = ,E, submap, reset
      bind = ,H, exec, bitwarden
      bind = ,H, submap, reset
      bind = ,P, exec, sudo -E gparted
      bind = ,P, submap, reset
      bind = ,B, exec, blueberry
      bind = ,B, submap, reset
      bind = ,O, exec, libreoffice
      bind = ,O, submap, reset
      bind = ,Y, exec, freetube
      bind = ,Y, submap, reset
      bind = ,W, exec, popcorntime
      bind = ,W, submap, reset
      submap = reset

      # CRYPTO STUFF
      bind = SUPER, C, submap, crypto
      submap = crypto
      bind = ,B, exec, docker exec -e XDG_RUNTIME_DIR='/run/user/1000' -e DISPLAY=$DISPLAY -u ${userSettings.username} apps binance
      bind = ,B, submap, reset
      bind = ,C, exec, qutebrowser https://coinmarketcap.com/
      bind = ,C, submap, reset
      bind = ,P, exec, qutebrowser https://mail.proton.me/
      bind = ,P, submap, reset
      bind = ,E, exec, docker_exec exodus
      bind = ,E, submap, reset
      submap = reset

      # TOGGLE STUFF
      bind = SUPER, T, submap, toggle
      submap = toggle
      bind = ,T, exec, theme_choose
      bind = ,T, submap, reset
      bind = ,B, exec, toggle_cpu
      bind = ,B, submap, reset
      bind = ,V, exec, toggle_vpn
      bind = ,V, submap, reset
      bind = ,S, exec, toggle_service
      bind = ,S, submap, reset
      bind = ,Q, exec, toggle_service stop
      bind = ,Q, submap, reset
      bind = ,C, exec, screen_chill
      bind = ,C, submap, reset
      bind = ,F, exec, screen_full
      bind = ,F, submap, reset
      bind = ,W, exec, screen_work
      bind = ,W, submap, reset
      submap = reset

      # VIRTUALIZATION
      bind = SUPER, V, submap, virtual
      submap = virtual
      bind = ,V, exec, vms_run
      bind = ,V, submap, reset
      bind = ,M, exec, GTK_THEME=Dracula virt-manager
      bind = ,M, submap, reset
      bind = ,B, exec, flatpak run com.usebottles.bottles
      bind = ,B, submap, reset
      bind = ,S, exec, stop_docker
      bind = ,S, submap, reset
      bind = ,D, exec, container_run debian
      bind = ,D, submap, reset
      bind = ,K, exec, container_run
      bind = ,K, submap, reset
      bind = ,W, exec, looking-glass-client #vms_run win10
      bind = ,W, submap, reset
      bind = ,A, exec, container_run apps
      bind = ,A, submap, reset
      bind = ,U, exec, container_run ubuntu
      bind = ,U, submap, reset
      bind = ,O, exec, container_run opensuse
      bind = ,O, submap, reset
      bind = ,P, exec, container_run parrot
      bind = ,P, submap, reset
      bind = ,F, exec, container_run fedora
      bind = ,F, submap, reset
      bind = ,R, exec, remmina -c .local/share/remmina/group_rdp_win11_192-168-122-106.remmina #GTK_THEME=Dracula remmina
      bind = ,R, submap, reset
      submap = reset

      # CHAT ing...
      bind = SUPER, I, submap, chat
      submap = chat
      bind = ,D, exec, flatpak run --socket=wayland com.discordapp.Discord --enable-features=UseOzonePlatform --ozone-platform=wayland
      bind = ,D, submap, reset
      bind = ,T, exec, webcord
      bind = ,T, submap, reset
      bind = ,W, exec, flatpak run io.github.mimbrero.WhatsAppDesktop
      bind = ,W, submap, reset
      bind = ,S, exec, flatpak run org.signal.Signal
      bind = ,S, submap, reset
      submap = reset

      # Setting Programm opacity
      windowrulev2 = opacity 0.98 0.88,class:(.*)
      windowrulev2 = opacity 0.96 0.8,class:(Alacritty)
      windowrulev2 = opacity 0.96 0.8,class:(Kitty)
      #windowrulev2 = opacity 1 0.85,class:(Emacs)
      windowrulev2 = opacity 0.94 0.82,class:(steam)
      windowrulev2 = opacity 0.99 0.98,class:(brave-browser)
      windowrulev2 = opacity 1 1,class:(cs2)
      windowrulev2 = opacity 1 1,class:(FreeTube)
      windowrulev2 = opacity 1 1,class:(Thorium-browser)
      windowrulev2 = tile ,class:(FreeTube)
      windowrulev2 = opacity 1 1,class:(discord)
      windowrulev2 = opacity 1 1,class:(looking-glass-client)
      windowrulev2 = opacity 1 1,class:(fuzzel)
      windowrulev2 = opacity 1 1,title:(Picture in picture)

      # Floating windows
      windowrulev2 = float,class:(cs2)
      windowrulev2 = float,class:(signal)
      windowrulev2 = float,class:(ollama)
      windowrulev2 = float,class:(whatsapp-desktop-linux)
      windowrulev2 = float,class:(steamwebhelper)
      windowrulev2 = float,class:(xdg-desktop-portal-gtk)
      windowrulev2 = float,class:(blueberry.py)
      windowrulev2 = float,class:(brave-nngceckbapebfimnlniiiahkandclblb-Default)
      windowrulev2 = float,class:(com.github.hluk.copyq)

      # Resize Windows
      windowrulev2 = size 950 600,class:(signal)
      windowrulev2 = center,class:(signal)
      windowrulev2 = size 950 600,class:(ollama)
      windowrulev2 = center,class:(ollama)
      windowrulev2 = size 950 600,class:(brave-nngceckbapebfimnlniiiahkandclblb-Default)
      windowrulev2 = center,class:(brave-nngceckbapebfimnlniiiahkandclblb-Default)
      windowrulev2 = size 950 600,class:(whatsapp-desktop-linux)
      windowrulev2 = center,class:(whatsapp-desktop-linux)
      windowrulev2 = size 950 600,class:(com.github.hluk.copyq)
      windowrulev2 = center,class:(com.github.hluk.copyq)
    '';
  };
}