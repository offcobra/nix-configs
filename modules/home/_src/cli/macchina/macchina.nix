{ systemSettings, ... }:

let
  interface = if (systemSettings.hostname == "workstation") then "enp14s0" else "wlp0s20f3";
  backlight = if (systemSettings.hostname == "workstation") then "" else "\'Backlight\',";
in
{
  # Macchina Configs
  home.file = {
    "nix.txt" = {
      enable = true;
      target = ".config/macchina/themes/nix.txt";
      source = ./nix.txt;
    };
    "custom.toml" = {
      enable = true;
      target = ".config/macchina/themes/custom.toml";
      source = ./custom.toml;
    };
    "macchina.toml" = {
      enable = true;
      target = ".config/macchina/macchina.toml";
      text = "
# Network
interface = '${interface}'

# Lengthen uptime output
long_uptime = true

# Lengthen shell output
long_shell = true

# Lengthen kernel output
long_kernel = true

# Long or short shell
current_shell = true

# Toggle between cores
# processor.
physical_cores = false

# Theme to choose
theme = 'custom'

# Displays only the specified readouts.
# Accepted values (case-sensitive):
#   - Host
#   - Machine
#   - Kernel
#   - Distribution
#   - OperatingSystem
#   - DesktopEnvironment
#   - WindowManager
#   - Resolution
#   - Backlight
#   - Packages
#   - LocalIP
#   - Terminal
#   - Shell
#   - Uptime
#   - Processor
#   - ProcessorLoad
#   - Memory
#   - Battery
#   - GPU
#   - DiskSpace
# Example:
show = [ 'Machine', 'Host', 'Distribution', 'Resolution', 'DesktopEnvironment', 'Terminal', 'Kernel', 'LocalIP', 'Processor', 'ProcessorLoad', 'Memory', 'Battery', ${backlight} 'Uptime', 'Packages', 'Shell', 'Terminal']
      ";
    };
  };
}
