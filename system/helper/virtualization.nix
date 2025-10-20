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

      # Enable Container
      #podman.enable = true;
      # Install pipewire-pulse for sound in arch!
      docker.enable = true;
    }

    # No libvirtd everywhere else..
    else {
      libvirtd.enable = false;

      # Enable Container
      #podman.enable = true;
      docker.enable = true;
    };
}
