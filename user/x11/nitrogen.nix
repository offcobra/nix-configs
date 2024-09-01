{ systemSettings, userSettings, ... }:

{
  # Nitrogen Configs
  home.file = {
    "bg-saved.cfg" = {
      enable = true;
      target = ".config/nitrogen/bg-saved.cfg";
      text = if (systemSettings.hostname == "workstation")
        then
 "[xin_0]
 file=/home/${userSettings.username}/.config/nixos/user/wallpapers/rainforest.jpg
 mode=0
 bgcolor=#000000

 [xin_1]
 file=/home/${userSettings.username}/.config/nixos/user/wallpapers/neversettle.jpg
 mode=0
 bgcolor=#000000

 [xin_2]
 file=/home/${userSettings.username}/.config/nixos/user/wallpapers/opensource.jpg
 mode=0
 bgcolor=#000000"
        else
 "[xin_0]
 file=/home/${userSettings.username}/.config/nixos/user/wallpapers/rainforest.jpg
 mode=0
 bgcolor=#000000";
    };
  };
}
