{ pkgs, ... }:

{
  # Thundar File Manager
  programs.xfconf.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-vcs-plugin
      thunar-volman
    ];
  };

  # Thumpnail support
  services.tumbler.enable = true;
}
