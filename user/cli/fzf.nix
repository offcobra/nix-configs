{ config, pkgs, ... }:

{
  # fzf Configs
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
}
