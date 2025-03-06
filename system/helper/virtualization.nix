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
          ovmf.enable = true;
          ovmf.packages = [ pkgs.OVMFFull.fd ];
        };
      };
      spiceUSBRedirection.enable = true;

      # Enable Container
      podman.enable = true;
    }

    # No libvirtd everywhere else..
    else {
      libvirtd.enable = false;

      # Enable Container
      #podman.enable = true;
      docker.enable = true;
    };
}
