{ config, pkgs, ...}:

let
  tuigreet_params = "--remember --remember-user-session --time --greeting 'Be amazed by the power of NixOs...'";
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --sessions ${config.services.displayManager.sessionData.desktops}/share/xsessions:${config.services.displayManager.sessionData.desktops}/share/wayland-sessions ${tuigreet_params}";
        user = "greeter";
      };
    };
  };
}
