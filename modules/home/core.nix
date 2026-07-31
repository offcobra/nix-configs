# Aspect: homeCore -- the wally home baseline (session env + a couple packages).
# Ported from the top of the old user/home.nix. colorScheme comes from the
# `colors` aspect; identity from the `wally` aspect.
{ config, ... }:
let
  c = config.constants;
in
{
  flake.modules.homeManager.homeCore =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ dconf ];

      home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        NIXOS_OZONE_WL = "1";
        XKB_DEFAULT_LAYOUT = "de";
        PAGER = "bat --pager 'less'";
        LIBVIRT_DEFAULT_URI = "qemu:///system";
        NH_FLAKE = "/home/${c.username}/.config/nixos";
        SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS = "0";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        HYPRSHOT_DIR = "/home/${c.username}/Pictures/Screenshots";
        _ZO_DOCTOR = "0";
      };

      home.sessionPath = [ "$HOME/.local/bin" ];
    };
}
