{ inputs, lib, pkgs, systemSettings, config, ... }:

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

    echo "Starting Foot Server..."
    foot --server &

    #echo "Starting Pyprland for plugins..."
    #pypr &

    if [[ ${systemSettings.hostname} == "workstation" ]]
    then
      echo "Starting Waybar..."
      #waybar &
      noctalia-shell &

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
  sens = if (systemSettings.hostname == "thinkpad") then 0.5 else 0;

  # Monitor layout per host. In Lua mode each entry becomes an `hl.monitor({...})`
  # call, so we describe the monitor as a table instead of a hyprlang string.
  monitors = if (systemSettings.hostname == "workstation")
             then
               [ { output = "DP-1";     mode = "1920x1080@144.00"; position = "0x0";    scale = 1; }
                 { output = "HDMI-A-1"; mode = "2560x1440@143.91"; position = "1920x0"; scale = 1; }
                 { output = "DP-3";     mode = "1920x1080";        position = "4480x0"; scale = 1; } ]
             else if (systemSettings.hostname == "thinkpad")
             then [ { output = "eDP-1"; mode = "1920x1080"; position = "0x0"; scale = 1; } ]
             else
               [ { output = "HDMI-A-1"; mode = "3840x2160@60.00"; position = "0x0"; scale = 2; } ];

in
{
  imports =
    [ # Include other modules
      # HyprPaper
      #./hyprpaper.nix
      # Waybar
      #./waybar
      #./ashell.nix
      # Terminals
      ./foot.nix
      # Launcher
      ./fuzzel.nix
      # Hyprlock
      #./hyprlock.nix
      # Hypridle
      #./hypridle.nix
      # Hyprshell
      #./hyprshell.nix
      # Wlogout
      #./wlogout
      # Pyprland
      #./pyprland.nix
    ];

  home.packages = with pkgs; [
    # Screenshot tools
    hyprshot
    hyprpicker
    wl-clipboard
    noctalia-shell
    #pyprland
  ];

  # Window Manager
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    configType = "lua";
    xwayland = {
      enable = true;
    };
    systemd.enable = true;
    systemd.variables = [ "--all" ];

    # Structured settings. In Lua mode the Home Manager module renders every
    # top-level key `name` as `hl.name(...)`, and the `config` attrset becomes
    # a single `hl.config({...})` holding the classic config categories.
    settings = {
      # One `hl.monitor({...})` per entry.
      monitor = monitors;

      config = {
        general = {
          gaps_in = 5;
          gaps_out = 5;
          layout = "master";
          border_size = 1;
          col = {
            active_border = "rgba(${config.colorScheme.palette.base0E}ee)";
            inactive_border = "rgba(${config.colorScheme.palette.base00}aa)";
          };
        };

        # Recomended Hypr Cursor settings for nvidia
        cursor = {
          no_hardware_cursors = (systemSettings.hostname == "mediatv");
        };

        input = {
          kb_layout = "de";
          follow_mouse = 1;
          scroll_factor = 1.5;
          sensitivity = sens; # -1.0 - 1.0, 0 means no modification.
          accel_profile = "flat";
          touchpad = {
            natural_scroll = false;
          };
        };

        misc = {
          enable_swallow = true;
          swallow_regex = "^(Alacritty|kitty|footclient|foot)$";
        };

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

        dwindle = {
          preserve_split = true;
        };

        master = {
          new_on_top = true;
          new_status = "master";
        };

        debug = {
          disable_logs = false;
        };

        # XWayland scaling
        xwayland = {
          force_zero_scaling = true;
        };
      };
    };

    # Keybinds, submaps and autostart are expressed as raw Lua. The latest
    # Hyprland uses a Lua config, so binds are `hl.bind(<keys>, <dispatcher>)`
    # and dispatchers live under `hl.dsp.*`. Submaps (keychords) are defined
    # with `hl.define_submap`; passing "reset" makes the submap exit after any
    # dispatch, which is exactly the "press a chord, run one thing" behaviour.
    extraConfig = ''
      -- Autostart
      hl.on("hyprland.start", function()
        hl.exec_cmd("${startup}/bin/hypr-startup")
      end)

      -- Move/resize windows with SUPER + LMB/RMB and dragging
      hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
      hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

      -- Terminals
      hl.bind("SUPER + return", hl.dsp.exec_cmd("footclient -e fish"))
      hl.bind("CTRL + return",  hl.dsp.exec_cmd("alacritty"))
      hl.bind("ALT + return",   hl.dsp.exec_cmd("ghostty"))

      -- Clipboard manager
      hl.bind("CTRL + P", hl.dsp.exec_cmd("clipman pick -t STDOUT | fuzzel --dmenu | wl-copy"))

      -- Ollama AI Chat
      hl.bind("SUPER + O", hl.dsp.exec_cmd("footclient -a ollama --title Ollama -e ollama run gemma3:latest"))
      -- NOTE: this used to also be bound to SUPER + return, which collided with
      -- the terminal above. Kept here on its own; rebind if you want it back.
      -- hl.bind("SUPER + return", hl.dsp.exec_cmd("virt-run.py --pods arch"))

      -- Session menu
      hl.bind("SUPER + Z", hl.dsp.exec_cmd("noctalia-shell ipc call sessionMenu toggle"))

      -- Window actions
      hl.bind("CTRL + space",       hl.dsp.window.fullscreen_state({ internal = 0, client = 1 }))
      hl.bind("SUPER + Q",          hl.dsp.window.close())
      hl.bind("SUPER + SHIFT + Q",  hl.dsp.exec_cmd("kill-wm.sh"))
      hl.bind("SUPER + SHIFT + F",  hl.dsp.window.float({ action = "toggle" }))
      hl.bind("SUPER + CTRL + F",   hl.dsp.window.fullscreen())
      hl.bind("SUPER + CTRL + L",   hl.dsp.exec_cmd("hyprlock"))
      hl.bind("SUPER + SHIFT + B",  hl.dsp.exec_cmd("toggle-proc.sh waybar"))

      -- Quick shortcuts
      hl.bind("SUPER + P",          hl.dsp.exec_cmd("noctalia-shell ipc call launcher toggle"))
      hl.bind("SUPER + SHIFT + P",  hl.dsp.exec_cmd("websearch.py"))
      hl.bind("SUPER + F",          hl.dsp.exec_cmd("thunar"))
      hl.bind("ALT + F",            hl.dsp.exec_cmd("footclient -e lf"))
      hl.bind("SUPER + S",          hl.dsp.exec_cmd("alacritty -e btm"))

      -- Move focus
      hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
      hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
      hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
      hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))

      -- Move window
      hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
      hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
      hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
      hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

      -- Resize the active window
      hl.bind("SUPER + ALT + H", hl.dsp.window.resize({ x = -30, y = 0,   relative = true }))
      hl.bind("SUPER + ALT + L", hl.dsp.window.resize({ x = 30,  y = 0,   relative = true }))
      hl.bind("SUPER + ALT + K", hl.dsp.window.resize({ x = 0,   y = -30, relative = true }))
      hl.bind("SUPER + ALT + J", hl.dsp.window.resize({ x = 0,   y = 30,  relative = true }))

      -- Workspaces: SUPER + [1-9,0] to switch, SUPER + SHIFT + [1-9,0] to move
      for i = 1, 10 do
        local key = i % 10 -- 10 maps to key "0"
        hl.bind("SUPER + " .. key,         hl.dsp.focus({ workspace = i }))
        hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
      end

      -- Scroll through workspaces with SUPER + scroll
      hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
      hl.bind("SUPER + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

      -- Sound controls
      hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("amixer sset Master 5%+"))
      hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("amixer sset Master 5%-"))
      hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("amixer sset Master 0"))

      -- Misc
      hl.bind("XF86NotificationCenter", hl.dsp.exec_cmd("show-info.sh"))

      -- Brightness controls
      hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("light -U 5"))
      hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("light -A 5"))

      -- Pyprland scratchpad
      hl.bind("F12", hl.dsp.exec_cmd("pypr toggle system_monitor"))

      ------------------------------------------------------------------
      -- SUBMAPS / Keychords
      ------------------------------------------------------------------

      -- Resize mode: stays active (repeat) until Escape.
      hl.define_submap("resize", function()
        hl.bind("L", hl.dsp.window.resize({ x = 10,  y = 0,   relative = true }), { repeating = true })
        hl.bind("H", hl.dsp.window.resize({ x = -10, y = 0,   relative = true }), { repeating = true })
        hl.bind("K", hl.dsp.window.resize({ x = 0,   y = -10, relative = true }), { repeating = true })
        hl.bind("J", hl.dsp.window.resize({ x = 0,   y = 10,  relative = true }), { repeating = true })
        hl.bind("escape", hl.dsp.submap("reset"))
      end)
      hl.bind("ALT + R", hl.dsp.submap("resize"))

      -- Browsers
      hl.define_submap("browsers", "reset", function()
        hl.bind("B", hl.dsp.exec_cmd("brave"))
        hl.bind("I", hl.dsp.exec_cmd("brave --incognito"))
        hl.bind("T", hl.dsp.exec_cmd("distrobox-enter -n arch  --  /usr/bin/thorium-browser %U"))
        hl.bind("H", hl.dsp.exec_cmd("distrobox-enter -n arch  --  /usr/bin/thorium-browser --incognito %U"))
        hl.bind("O", hl.dsp.exec_cmd("qutebrowser"))
        hl.bind("Z", hl.dsp.exec_cmd("flatpak run app.zen_browser.zen"))
        hl.bind("escape", hl.dsp.submap("reset"))
      end)
      hl.bind("SUPER + B", hl.dsp.submap("browsers"))

      -- Programs
      hl.define_submap("programms", "reset", function()
        hl.bind("G", hl.dsp.exec_cmd("steam"))
        hl.bind("V", hl.dsp.exec_cmd("noctalia-shell ipc call volume openPanel"))
        hl.bind("F", hl.dsp.exec_cmd("flatpak run com.github.tchx84.Flatseal"))
        hl.bind("S", hl.dsp.exec_cmd("spotify --enable-features=UseOzonePlatform --ozone-platform=wayland"))
        hl.bind("E", hl.dsp.exec_cmd("thunderbird"))
        hl.bind("H", hl.dsp.exec_cmd("flatpak run me.proton.Pass"))
        hl.bind("P", hl.dsp.exec_cmd("flatpak run me.proton.Mail"))
        hl.bind("B", hl.dsp.exec_cmd("noctalia-shell ipc call bluetooth togglePanel"))
        hl.bind("O", hl.dsp.exec_cmd("libreoffice"))
        hl.bind("Y", hl.dsp.exec_cmd("freetube"))
        hl.bind("W", hl.dsp.exec_cmd("waypaper"))
        hl.bind("escape", hl.dsp.submap("reset"))
      end)
      hl.bind("SUPER + G", hl.dsp.submap("programms"))

      -- Crypto
      hl.define_submap("crypto", "reset", function()
        hl.bind("B", hl.dsp.exec_cmd("distrobox-enter -n arch -- /usr/sbin/binance"))
        hl.bind("C", hl.dsp.exec_cmd("qutebrowser --target window https://coinmarketcap.com/"))
        hl.bind("V", hl.dsp.exec_cmd("qutebrowser --target window https://de.tradingview.com/chart/2eropQd2/?symbol=BINANCE%3ABTCUSDT"))
        hl.bind("E", hl.dsp.exec_cmd("distrobox-enter -n arch -- exodus"))
        hl.bind("T", hl.dsp.exec_cmd("footclient -e cointop"))
        hl.bind("escape", hl.dsp.submap("reset"))
      end)
      hl.bind("SUPER + C", hl.dsp.submap("crypto"))

      -- Editor
      hl.define_submap("editor", "reset", function()
        hl.bind("N", hl.dsp.exec_cmd("footclient -e nvim"))
        hl.bind("escape", hl.dsp.submap("reset"))
      end)
      hl.bind("SUPER + E", hl.dsp.submap("editor"))

      -- Toggles
      hl.define_submap("toggle", "reset", function()
        hl.bind("U", hl.dsp.exec_cmd("footclient -a update --title Update... -e update"))
        hl.bind("B", hl.dsp.exec_cmd("toggle-cpu.sh"))
        hl.bind("H", hl.dsp.exec_cmd("toggle-bluetooth.sh"))
        hl.bind("V", hl.dsp.exec_cmd("flatpak run com.protonvpn.www"))
        hl.bind("S", hl.dsp.exec_cmd("toggle_service"))
        hl.bind("Q", hl.dsp.exec_cmd("toggle_service stop"))
        hl.bind("C", hl.dsp.exec_cmd("screen-chill.sh"))
        hl.bind("F", hl.dsp.exec_cmd("screen-full.sh"))
        hl.bind("W", hl.dsp.exec_cmd("screen-work.sh"))
        hl.bind("Z", hl.dsp.exec_cmd("noctalia-shell ipc call settings toggle"))
        hl.bind("D", hl.dsp.exec_cmd("noctalia-shell ipc call notifications toggleDND"))
        hl.bind("I", hl.dsp.exec_cmd("noctalia-shell ipc call idleInhibitor toggle"))
        hl.bind("escape", hl.dsp.submap("reset"))
      end)
      hl.bind("SUPER + T", hl.dsp.submap("toggle"))

      -- Virtualization
      hl.define_submap("virtio", "reset", function()
        hl.bind("V", hl.dsp.exec_cmd("virt-run.py --vms choice"))
        hl.bind("M", hl.dsp.exec_cmd("GTK_THEME=Dracula virt-manager"))
        hl.bind("B", hl.dsp.exec_cmd("flatpak run com.usebottles.bottles"))
        hl.bind("S", hl.dsp.exec_cmd("virt-run.py --stop"))
        hl.bind("D", hl.dsp.exec_cmd("virt-run.py --pods debian"))
        hl.bind("K", hl.dsp.exec_cmd("virt-run.py --pods choice"))
        hl.bind("W", hl.dsp.exec_cmd("virt-run.py --vms win11"))
        hl.bind("G", hl.dsp.exec_cmd("looking-glass-client input:autocapture=yes -F"))
        hl.bind("U", hl.dsp.exec_cmd("virt-run.py --pods ubuntu"))
        hl.bind("F", hl.dsp.exec_cmd("virt-run.py --pods fedora"))
        hl.bind("R", hl.dsp.exec_cmd("xfreerdp -grab-keyboard /v:192.168.122.167 /u:Quickemu /p:scrima /size:100% /dynamic-resolution /gfx:avc444 /gfx:progressive=true"))
        hl.bind("escape", hl.dsp.submap("reset"))
      end)
      hl.bind("SUPER + V", hl.dsp.submap("virtio"))

      -- Chat
      hl.define_submap("chat", "reset", function()
        hl.bind("D", hl.dsp.exec_cmd("flatpak run com.discordapp.Discord"))
        hl.bind("W", hl.dsp.exec_cmd("flatpak run com.rtosta.zapzap"))
        hl.bind("S", hl.dsp.exec_cmd("flatpak run org.signal.Signal"))
        hl.bind("T", hl.dsp.exec_cmd("distrobox-enter -n arch  --  /usr/bin/stoat-desktop %U"))
        hl.bind("escape", hl.dsp.submap("reset"))
      end)
      hl.bind("SUPER + I", hl.dsp.submap("chat"))

      -- Screenshots
      hl.define_submap("screenshot", "reset", function()
        hl.bind("P", hl.dsp.exec_cmd("hyprpicker | wl-copy"))
        hl.bind("W", hl.dsp.exec_cmd("hyprshot -m window"))
        hl.bind("M", hl.dsp.exec_cmd("hyprshot -m output"))
        hl.bind("R", hl.dsp.exec_cmd("hyprshot -m region"))
        hl.bind("escape", hl.dsp.submap("reset"))
      end)
      hl.bind("PRINT", hl.dsp.submap("screenshot"))

      ------------------------------------------------------------------
      -- Window rules (ported from the old hyprlang config).
      -- Field names for opacity/size/center/move follow the Lua API; verify
      -- against https://wiki.hypr.land/Configuring/Basics/Window-Rules/ and
      -- uncomment the ones you want.
      ------------------------------------------------------------------
      -- hl.window_rule({ match = { class = "ollama" },        float = true, size = "950 600", center = true })
      -- hl.window_rule({ match = { title = "Picture-in-Picture" }, float = true, size = "950 600", center = true })
      -- hl.window_rule({ match = { class = "thorium-browser" }, tile = true })
      -- hl.window_rule({ match = { class = "FreeTube" },        tile = true })

      -- Workspace rules
      hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1", default = true })
    '';
  };
  }
