{ pkgs, systemSettings, ... }:

{
  # Virtualization
  # GPU Passthrough ready
  virtualisation =

    # On Workstation libvirtd should be enabled
    if systemSettings.hostname == "workstation"
    then {
      libvirtd = {
        enable = true;
        onBoot = "ignore";
        qemu = {
          swtpm.enable = true;
        };
      };
      spiceUSBRedirection.enable = true;

    }

    # No libvirtd everywhere else..
    else {
      libvirtd.enable = false;

    };

    # Enable Container
    # Install pipewire-pulse for sound in arch!
    podman = {
      enable = true;
      dockerSocket.enable = true;
      autoPrune.enable = true;
    };
    docker.enable = false;
}
