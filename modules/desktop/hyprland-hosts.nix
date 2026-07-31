# Per-host Hyprland values. Each hyprland<Host> aspect pairs with the shared
# `hyprland` aspect and carries exactly what differed under the old
# `if hostname ==` branching: monitors, blur, mouse sensitivity, hardware
# cursors, and the autostart script. Each host composes `hyprland` + its own
# aspect; nothing here is shared, so nothing can silently leak across machines.
{ inputs, ... }:
let
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;

  # Services every Hyprland machine starts. Each host script embeds this and
  # appends its own extras, so each machine still reads as one plain script.
  commonStartup = ''
    echo "Starting NM-Applet..."
    nm-applet &

    echo "Starting HyprIdle..."
    hypridle &

    echo "Clipboard Manager..."
    wl-paste -t text --watch clipman store --no-persist &

    echo "Starting Foot Server..."
    foot --server &
  '';

  mkStartup = extra: pkgs.writeShellScriptBin "hypr-startup" (commonStartup + extra);

  mkAutostart = startup: ''
    -- Autostart
    hl.on("hyprland.start", function()
      hl.exec_cmd("${startup}/bin/hypr-startup")
    end)
  '';
in
{
  flake.modules.homeManager.hyprlandWorkstation =
    let
      startup = mkStartup ''
        echo "Starting Noctalia Shell..."
        noctalia-shell &

        echo "Starting Signal & WhatsApp..."
        flatpak run org.signal.Signal --start-in-tray &
        flatpak run com.rtosta.zapzap --start-hidden &

        echo "Starting sound Equilizer..."
        flatpak run me.timschneeberger.jdsp4linux --tray
      '';
    in
    {
      wayland.windowManager.hyprland = {
        settings = {
          monitor = [
            { output = "DP-1"; mode = "1920x1080@144.00"; position = "0x0"; scale = 1; }
            { output = "HDMI-A-1"; mode = "2560x1440@143.91"; position = "1920x0"; scale = 1; }
            { output = "DP-3"; mode = "1920x1080"; position = "4480x0"; scale = 1; }
          ];
          config = {
            decoration.blur.enabled = true;
            input.sensitivity = 0;
            cursor.no_hardware_cursors = false;
          };
        };
        extraConfig = mkAutostart startup;
      };
    };

  flake.modules.homeManager.hyprlandThinkpad =
    let
      # The old config also started `watch_battery` here, but no such script
      # exists in the repo (casualty of the Qtile removal). Re-add it to
      # _src/cli/scripts and append it here if you want battery notifications.
      startup = mkStartup "";
    in
    {
      wayland.windowManager.hyprland = {
        settings = {
          monitor = [
            { output = "eDP-1"; mode = "1920x1080"; position = "0x0"; scale = 1; }
          ];
          config = {
            decoration.blur.enabled = false;
            input.sensitivity = 0.5;
            cursor.no_hardware_cursors = false;
          };
        };
        extraConfig = mkAutostart startup;
      };
    };

  flake.modules.homeManager.hyprlandMinipc =
    let
      startup = mkStartup "";
    in
    {
      wayland.windowManager.hyprland = {
        settings = {
          monitor = [
            { output = "HDMI-A-1"; mode = "3840x2160@60.00"; position = "0x0"; scale = 2; }
          ];
          config = {
            decoration.blur.enabled = false;
            input.sensitivity = 0;
            cursor.no_hardware_cursors = false;
          };
        };
        extraConfig = mkAutostart startup;
      };
    };

  flake.modules.homeManager.hyprlandMediatv =
    let
      startup = mkStartup ''
        # Laptop lid stays closed: panel off, TV on.
        wlr-randr --output eDP-1 --off --output HDMI-A-1 --mode 1920x1080@60.00
      '';
    in
    {
      wayland.windowManager.hyprland = {
        settings = {
          monitor = [
            { output = "HDMI-A-1"; mode = "3840x2160@60.00"; position = "0x0"; scale = 2; }
          ];
          config = {
            decoration.blur.enabled = false;
            input.sensitivity = 0;
            # Recommended for the nvidia legacy driver on this box.
            cursor.no_hardware_cursors = true;
          };
        };
        extraConfig = mkAutostart startup;
      };
    };
}
