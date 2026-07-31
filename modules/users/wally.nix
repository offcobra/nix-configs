# Aspect: wally. A user is a cross-cutting concern spanning both classes.
#
# Only groups that are always safe live here. Feature aspects extend this user:
# the virtualization aspect adds `libvirtd`/`kvm`, the containers aspect adds
# `docker`/`podman`, etc. NixOS merges `extraGroups` lists across modules, so
# those additions compose without editing this file.
{ config, ... }:
let
  c = config.constants;
  userName = c.username;
in
{
  flake.modules.nixos.wally =
    { pkgs, ... }:
    {
      users.users.${userName} = {
        isNormalUser = true;
        description = c.name;
        extraGroups = [ "wheel" "networkmanager" "video" "audio" "input" "storage" "disk" ];
        packages = with pkgs; [
          libnotify
          lm_sensors
          alsa-utils
          usbutils
          glib
        ];
      };
    };

  flake.modules.homeManager.wally = {
    home.username = userName;
    home.homeDirectory = "/home/${userName}";
    home.stateVersion = "23.11"; # per-user identity — do not change
  };
}
