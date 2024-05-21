{ config, pkgs, systemSettings, ... }:

{
  # Fuzzel App Launcher
  programs.fuzzel = {
    enable = true;
    package = pkgs.fuzzel;
    settings = {
      main = {
        font = "Firacodenerdfont:Semibold";
        #font = "FireCodeNerdFont";
        line-height = if (systemSettings.hostname == "workstation") then 16 else 10;
        width = 30;
        lines = 10;
        icons-enabled = "yes";
      };
      colors = {
        background = "282a36dd";
        text = "f8f8f2ff";
        match = "8be9fdff";
        selection-match = "8be9fdff";
        selection = "44475add";
        selection-text = "f8f8f2ff";
        border = "bd93f9ff";
      };
    };
  };
}

