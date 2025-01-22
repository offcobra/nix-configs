{ pkgs, ... }:

{
  security.sudo = {
    enable = true;
    extraRules = [{
      commands = [
        {
          command = "${pkgs.linuxKernel.packages.linux_zen.cpupower}/bin/cpupower frequency-set -g powersave";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.linuxKernel.packages.linux_zen.cpupower}/bin/cpupower frequency-set -g performance";
          options = [ "NOPASSWD" ];
        }
      ];
      groups = [ "wheel" ];
    }];
  };
}
