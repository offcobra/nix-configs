{ config, lib, pkgs, modulesPath, userSettings, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  # Set CPU Guvernor
  powerManagement.cpuFreqGovernor = "performance";

  # For games
  hardware.pulseaudio.support32Bit = true;

  # Enable OpenGL / Vulkan support
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      #clinfo
      rocmPackages.clr
      amdvlk
    ];
    extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;


  fileSystems."/" =
    { device = "/dev/disk/by-uuid/8b627f50-400b-4c56-828a-b6a5d238a13a";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/4123-A341";
      fsType = "vfat";
    };

  fileSystems."/home/${userSettings.username}/mySpace/backups" =
    { device = "/dev/sda1";
      fsType = "ext4";
    };

  fileSystems."/home/${userSettings.username}/mySpace/vms" =
    { device = "/dev/sda2";
      fsType = "ext4";
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp14s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp15s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
