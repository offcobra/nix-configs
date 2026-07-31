# Aspect: virtualization -- libvirtd (GPU-passthrough ready) + podman.
#
# This aspect also extends the user with the groups it needs; NixOS merges
# extraGroups across modules, so wally's base groups (in users/wally.nix) stay
# untouched. The looking-glass /dev/shm node is set up in the workstation host.
{ config, ... }:
let
  c = config.constants;
in
{
  flake.modules.nixos.virtualization = {
    virtualisation = {
      libvirtd = {
        enable = true;
        onBoot = "ignore";
        qemu.swtpm.enable = true;
      };
      spiceUSBRedirection.enable = true;
      podman = {
        enable = true;
        dockerSocket.enable = true;
        autoPrune.enable = true;
        defaultNetwork.settings.dns_enabled = true;
      };
      docker.enable = false;
    };

    users.users.${c.username}.extraGroups = [ "libvirtd" "qemu-libvirtd" "podman" "kvm" ];
  };
}
