{ pkgs, ... }:

{
  home.packages = [
    # ShellScript to toggle CPU Guvernor...
    (pkgs.writeShellScriptBin "toggle-cpu.sh" /*bash*/ ''
      STATUS=$(/run/current-system/sw/bin/cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
      echo "CPU Guvernor $STATUS ..."

      # Check what actuall Guvernor ist
      if [[ $STATUS == "performance" ]]; then
          # Set Guvernor to powersave
          notify-send -t 5000 "Toggle CPU" "Setting CPU Guvernor to powersave..."
          sudo ${pkgs.linuxKernel.packages.linux_zen.cpupower}/bin/cpupower frequency-set -g powersave
      else
          # Set Guvernor to performance
          notify-send -t 5000 "Toggle CPU" "Setting CPU Guvernor to performance..."
          sudo ${pkgs.linuxKernel.packages.linux_zen.cpupower}/bin/cpupower frequency-set -g performance
      fi
    '')
  ];
}
