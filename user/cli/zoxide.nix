{ ... }:

{
  # zoxide Configs
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    options = [
      "--cmd j"
    ];
  };
}
