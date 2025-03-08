{ pkgs, systemSettings, ... }:

let
  #rx580 = "1002:67df,1002:aaf0";
  #rx6700 = "1002:73df,1002:ab28";
  rtx2080 = "10de:1e81,10de:10f8,10de:1ad8,10de:1ad9";
in
{
  # Grub Bootloader with vfio setup
  boot = {
    tmp.cleanOnBoot = true;
    extraModulePackages = [ ];
    supportedFilesystems = [ "ntfs" ];
    # Set desired Kernel
    kernelPackages = pkgs.${systemSettings.kernel};
    #kernelModules = [ "kvm-amd" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
    blacklistedKernelModules = [ "nvidia" "nouveau" ];

    # Block primary GPU
    # lspci -nn
    # Nvidia rtx 2080 SUPER: 01:00.[0 -> 3] => 10de:1e81,10de:10f8,10de:1ad8,10de:1ad9
    # AMD Radeon RX 580: 12:00.0 12:00.1 -> 1002:67df 1002:aaf0
    # AMD Radeon RX 6700: 03:00.0 03:00.1 -> 1002:73df 1002:ab28
    # Test: dmesg | grep -i vfio

    # 1. Version
    kernelParams = [ "rd.driver.pre=vfio-pci" "amd_iommu=on" "iommu=pt" "video=efifb:off" "vfio-pci.ids=${rtx2080}" "hugepagesz=2M" "hugepages=6144" ];
    extraModprobeConfig = "options vfio-pci ids=${rtx2080}";

    # 2. Version
    # If first dosnt succssed
    #postBootCommands = ''
    #    DEVS="1002:73df 1002:ab28"
    #    for DEV in $DEVS; do
    #        echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
    #    done
    #    modprobe -i vfio-pci
    #'';

    initrd = {
      availableKernelModules = [ "nvme" "ahci" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
      kernelModules = [ "vfio_pci" "vfio" "vfio_iommu_type1" "kvm-amd" "amdgpu" ];
    };
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 3;
      };
    };
  };
}
