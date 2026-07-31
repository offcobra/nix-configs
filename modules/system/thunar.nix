# Aspect: thunar -- file manager + thumbnails.
{
  flake.modules.nixos.thunar =
    { pkgs, ... }:
    {
      programs.xfconf.enable = true;
      programs.thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar-vcs-plugin
          thunar-volman
        ];
      };
      services.tumbler.enable = true;
    };
}
