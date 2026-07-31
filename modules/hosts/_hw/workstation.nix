# Machine identity for workstation: hardware scan + boot + stateVersion.
#
# This is a PLAIN NixOS module (not a flake-parts aspect): `_`-prefixed paths
# are ignored by import-tree, so it is pulled in explicitly by the workstation
# host file. system.stateVersion is pinned here because it is a property of THIS
# installed machine and must never be "upgraded".
{ config, lib, pkgs, modulesPath, ... }:
let
  kernel = "linuxPackages_latest";
  # VFIO GPU passthrough: block the RTX 2080 Super from the host so a VM can
  # bind it. lspci -nn ids below.
  rtx2080 = "10de:1e81,10de:10f8,10de:1ad8,10de:1ad9";
in
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  system.stateVersion = "23.05"; # machine identity — do not change

  powerManagement.cpuFreqGovernor = "powersave";

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/8b627f50-400b-4c56-828a-b6a5d238a13a";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/4123-A341";
    fsType = "vfat";
  };
  fileSystems."/home/wally/mySpace/backups" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };
  fileSystems."/home/wally/mySpace/vms" = {
    device = "/dev/sda2";
    fsType = "ext4";
  };
  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  boot = {
    tmp.cleanOnBoot = true;
    supportedFilesystems = [ "ntfs" ];
    kernelPackages = pkgs.${kernel};
    blacklistedKernelModules = [ "nvidia" "nouveau" ];
    kernelParams = [
      "rd.driver.pre=vfio-pci"
      "amd_iommu=on"
      "iommu=pt"
      "video=efifb:off"
      "vfio-pci.ids=${rtx2080}"
      "hugepagesz=2M"
      "hugepages=8200"
    ];
    extraModprobeConfig = "options vfio-pci ids=${rtx2080}";
    initrd = {
      availableKernelModules = [ "nvme" "ahci" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
      kernelModules = [ "vfio_pci" "vfio" "vfio_iommu_type1" ];
    };
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 10;
      };
    };
  };
}
