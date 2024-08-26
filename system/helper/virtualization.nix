{ pkgs, ... }:

{
  # Virtualization
  # GPU Passthrough ready
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
  spiceUSBRedirection.enable = true;
  docker.enable = true;
  };
}
