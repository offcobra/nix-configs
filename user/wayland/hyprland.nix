{ inputs, pkgs, systemSettings, userSettings, config, ... }:

let startup = pkgs.pkgs.writeShellScriptBin "hypr-startup" /*bash*/ ''
    if [[ ${systemSettings.hostname} == "mediatv" ]]
    then
      # Setting Screens MediaTV
      wlr-randr --output eDP-1 --off --output HDMI-A-1 --mode 1920x1080@60.00
    fi

    #echo "Starting Emacs..."
    #emacs --daemon &

    echo "Starting NM-Applet..."
    nm-applet &

    echo "Starting HyprIdle..."
    hypridle &

    echo "Clipboard Manager..."
    wl-paste -t text --watch clipman store --no-persist &

    #echo "Starting Pyprland for plugins..."
    #pypr &

    if [[ ${systemSettings.hostname} == "workstation" ]]
    then
      echo "Starting Waybar..."
      waybar &

      echo "Starting Signal & WhatsApp..."
      flatpak run org.signal.Signal --start-in-tray &
      flatpak run com.rtosta.zapzap --start-hidden &

      echo "Starting sound Equilizer..."
      flatpak run me.timschneeberger.jdsp4linux --tray

    elif [[ ${systemSettings.hostname} == "thinkpad" ]]
    then
      # Get Battery Notificaions
      watch_battery &
    fi
  '';
  blur = if (systemSettings.hostname == "workstation") then true else false;
  install = if (systemSettings.hostname == "mediatv") then false else true;

in
{
  imports =
    [ # Include other modules
      # HyprPaper
      ./hyprpaper.nix
      # Waybar
      ./waybar
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
      # Pyprland
      ./pyprland.nix
    ];

  home.packages = with pkgs; [
    # Screenshot tools
    grim
    slurp
    hyprpicker
    wl-clipboard
    #pyprland
  ];

  # Window Manager
  wayland.windowManager.hyprland = {
    enable = install;
    xwayland = { enable = true; };
    systemd.enable = true;
    systemd.variables = [ "--all" ];
    #plugins = [
    #  inputs.hyprland-plugins.packages.${systemSettings.system}.hyprtrails
    #  inputs.hyprland-plugins.packages.${systemSettings.system}.csgo-vulkan-fix
    #];
    settings = {
      # Plugins
      #plugin = {
      #  # Todo fix rgba color...
      #  hyprtrails = {
      #    #color = "rgba(${config.colorScheme.palette.base00})";
      #    color = "rgba(226, 0, 0, 0.67)";
      #  };
      #  csgo-vulkan-fix = {
      #    res_w = 1280;
      #    res_h = 960;

      #    # NOT a regex! This is a string and has to exactly match initial_class
      #    #class = "cs2";
      #    class = "SDL Application";

      #    # Whether to fix the mouse position. A select few apps might be wonky with this.
      #    fix_mouse = true;
      #  };
      #};

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
        "col.active_border" = "rgba(${config.colorScheme.palette.base0E}ee)";
        "col.inactive_border" = "rgba(${config.colorScheme.palette.base00}aa)";
      };

      # Misc settings
      misc = {
        enable_swallow = "true";
      };

      # Startup Programms
      exec-once = ''${startup}/bin/hypr-startup'';

      # Decorations
      decoration = {
        rounding = 10;

        blur = {
    	  enabled = blur;
        };

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(${config.colorScheme.palette.base00}ee)";
        };
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
        "$mainMod, return, exec, alacritty -e fish"
        "CTRL, return, exec, foot"

        # Clipboard manager
        "CTRL, P, exec, clipman pick -t rofi"

        # Ollama AI Chat
        "$mainMod, o, exec, alacritty --class ollama --title Ollama -e ollama run llama3.2"
        "$mainMod_SHIFT, return, exec, virt-run.py --pods arch"

        # Screenshot
        # TODO user hyprshot...
        "$mainMod, x, exec, grim -g \"$(slurp -d)\""
        "$mainMod_SHIFT, X, exec, hyprpicker | wl-copy"

        # WLogout
        "$mainMod, z, exec, wlogout --protocol layer-shell -b 5"

        # Window Actions
        "CTRL, Space, fullscreenstate, 0, 1"
        "$mainMod, Q, killactive"
        "$mainMod_SHIFT, Q, exec, kill-wm.sh"
        #"$mainMod_SHIFT, R, hyprctl reload"
        "$mainMod_SHIFT, F, togglefloating"
        "$mainMod_CTRL, F, fullscreen"
        "$mainMod_CTRL , L, exec, hyprlock"
        "$mainMod_SHIFT, B, exec, toggle-proc.sh waybar"

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

        # Misc...
        # TODO add airplane-mode Key
        ", xf86Messenger, exec, show-info.sh"

        # Brightness controls
        ", xf86MonBrightnessDown, exec, light -U 5"
        ", xf86MonBrightnessUp, exec, light -A 5"

        # Pyprland Plugins
        # Scratchpads
        ", F12, exec, pypr toggle system_monitor"

      ];
    };
    extraConfig = ''
      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = SUPER, mouse:272, movewindow
      bindm = SUPER, mouse:273, resizewindow

      # Defining SUBMAPS / Keychords

      # Resize Window
      bind = ALT, R, submap, resize
      submap = resize
      binde = , L, resizeactive, 10 0
      binde = , H, resizeactive, -10 0
      binde = , K, resizeactive, 0 -10
      binde = , J, resizeactive, 0 10
      bind = , escape, submap, reset
      submap = reset

      # BROWSERS
      bind = SUPER, B, submap, browsers
      submap = browsers
      bind = ,B, exec, brave
      bind = ,B, submap, reset
      bind = ,I, exec, brave --incognito
      bind = ,I, submap, reset
      bind = ,T, exec, distrobox-enter -n arch  --  /usr/bin/thorium-browser %U
      bind = ,T, submap, reset
      bind = ,H, exec, distrobox-enter -n arch  --  /usr/bin/thorium-browser --incognito %U
      bind = ,H, submap, reset
      bind = ,O, exec, qutebrowser
      bind = ,O, submap, reset
      bind = ,Z, exec, flatpak run io.github.zen_browser.zen
      bind = ,Z, submap, reset
      bind = , escape, submap, reset
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
      bind = , escape, submap, reset
      submap = reset

      # PROGRAMMS
      bind = SUPER, G, submap, programms
      submap = programms
      bind = ,G, exec, steam
      bind = ,G, submap, reset
      bind = ,V, exec, pavucontrol
      bind = ,V, submap, reset
      bind = ,F, exec, flatpak run com.github.tchx84.Flatseal
      bind = ,F, submap, reset
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
      bind = , escape, submap, reset
      submap = reset

      # CRYPTO STUFF
      bind = SUPER, C, submap, crypto
      submap = crypto
      #bind = ,B, exec, qutebrowser https://binance.com
      bind = ,B, exec, distrobox-enter -n arch -- /usr/sbin/binance
      bind = ,B, submap, reset
      bind = ,C, exec, qutebrowser https://coinmarketcap.com/
      bind = ,C, submap, reset
      bind = ,P, exec, qutebrowser https://mail.proton.me/
      bind = ,P, submap, reset
      bind = ,E, exec, flatpak run io.exodus.Exodus
      bind = ,E, submap, reset
      bind = , escape, submap, reset
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
      bind = ,C, exec, screen-chill.sh
      bind = ,C, submap, reset
      bind = ,F, exec, screen-full.sh
      bind = ,F, submap, reset
      bind = ,W, exec, screen-work.sh
      bind = ,W, submap, reset
      bind = , escape, submap, reset
      submap = reset

      # VIRTUALIZATION
      bind = SUPER, V, submap, virtual
      submap = virtual
      bind = ,V, exec, virt-run.py --vms choice
      bind = ,V, submap, reset
      bind = ,M, exec, GTK_THEME=Dracula virt-manager
      bind = ,M, submap, reset
      bind = ,B, exec, flatpak run com.usebottles.bottles
      bind = ,B, submap, reset
      bind = ,S, exec, virt-run.py --stop
      bind = ,S, submap, reset
      bind = ,D, exec, virt-run.py --pods debian
      bind = ,D, submap, reset
      bind = ,K, exec, virt-run.py --pods choice
      bind = ,K, submap, reset
      bind = ,W, exec, virt-run.py --vms win11
      bind = ,W, submap, reset
      bind = ,G, exec, looking-glass-client input:autocapture=yes -F
      bind = ,G, submap, reset
      bind = ,U, exec, virt-run.py --pods ubuntu
      bind = ,U, submap, reset
      bind = ,F, exec, virt-run.py --pods fedora
      bind = ,F, submap, reset
      #bind = ,R, exec, remmina -c .local/share/remmina/group_rdp_win11_192-168-122-167.remmina #GTK_THEME=Dracula remmina
      bind = ,R, exec, xfreerdp -grab-keyboard /v:192.168.122.167 /u:Quickemu /p:scrima /size:100% /dynamic-resolution /gfx:avc444 /gfx:progressive=true
      bind = ,R, submap, reset
      bind = , escape, submap, reset
      submap = reset

      # CHAT ing...
      bind = SUPER, I, submap, chat
      submap = chat
      bind = ,D, exec, webcord
      bind = ,D, submap, reset
      bind = ,W, exec, flatpak run com.rtosta.zapzap
      bind = ,W, submap, reset
      bind = ,S, exec, flatpak run org.signal.Signal
      bind = ,S, submap, reset
      bind = , escape, submap, reset
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
      windowrulev2 = opacity 1 1,class:(thorium-browser)
      windowrulev2 = opacity 1 1,class:(discord)
      windowrulev2 = opacity 1 1,class:(looking-glass-client)
      windowrulev2 = opacity 1 1,class:(fuzzel)
      windowrulev2 = opacity 1 1,title:(Picture in picture)

      # Tile Programs
      windowrulev2 = tile ,class:(thorium-browser)
      windowrulev2 = tile ,class:(FreeTube)

      # Floating windows
      windowrulev2 = float,class:(cs2)
      windowrulev2 = float,class:(signal)
      windowrulev2 = float,class:(ollama)
      windowrulev2 = float,title:(SysMon)
      windowrulev2 = float,class:(ZapZap)
      windowrulev2 = float,class:(steamwebhelper)
      windowrulev2 = float,class:(xdg-desktop-portal-gtk)
      windowrulev2 = float,class:(blueberry.py)
      windowrulev2 = float,class:(brave-nngceckbapebfimnlniiiahkandclblb-Default)

      # Resize Windows
      windowrulev2 = size 950 600,class:(signal)
      windowrulev2 = center,class:(signal)
      windowrulev2 = size 950 600,class:(ollama)
      windowrulev2 = center,class:(ollama)
      windowrulev2 = size 950 600,class:(brave-nngceckbapebfimnlniiiahkandclblb-Default)
      windowrulev2 = center,class:(brave-nngceckbapebfimnlniiiahkandclblb-Default)
      windowrulev2 = size 950 600,class:(ZapZap)
      windowrulev2 = center,class:(ZapZap)
    '';
  };
}
