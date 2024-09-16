{ pkgs, ... }:

{
  home.packages = [
    # ShellScript to show current Battery & Time Info
    (pkgs.writeShellScriptBin "show-info.sh" /*bash*/ ''
      #         

      date1=$(date +%d.%m.%Y)
      time=$(date +%H:%M:%S)
      bat=$(acpi | cut -d ","  -f 2 | xargs)
      bat1=$(acpi | cut -d ","  -f 3 | xargs)

      #notify-send -t 2500 "$date" "$bat"
      notify-send -t 2000 "  ---    $time  󱑂 " "  ----    $date1"
      sleep 1
      notify-send -t 2000 "  ---    Battery: $bat   " "  ----    $bat1"
    '')

    # Shell Scripts
    (pkgs.writeShellScriptBin "airplane-mode" ''
      #!/bin/sh
      connectivity="$(nmcli n connectivity)"
      if [ "$connectivity" == "full" ]
      then
          notify-send -t 2000 "Network Status" "[CRITICAL] Airplane Mode: ON !!!"
          nmcli n off
      else
          notify-send -t 2000 "Network Status" "[CRITICAL] Airplane Mode: OFF !!!"
          nmcli n on
      fi
    '')
  ];
}
