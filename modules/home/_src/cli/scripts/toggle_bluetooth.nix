{ pkgs, ... }:

{
  home.packages = [
    # ShellScript to toggle the a1 Soundcore earbuds...
    (pkgs.writeShellScriptBin "toggle-bluetooth.sh" /*bash*/ ''
      # TODO: upower for battery status...
      STATUS=$(bluetoothctl devices Connected)

      # Check if Device is connected
      if [[ -z $STATUS ]]; then
          # Connect to A1 Soundcore
          bluetoothctl connect E8:EE:CC:9A:F9:6F
          notify-send -t 5000 " Bluetooth Control" "Status 󰂱 to A1..."
      else
          # Disconnect from A1 Soundcore
          bluetoothctl disconnect E8:EE:CC:9A:F9:6F
          notify-send -t 5000 " Bluetooth Control" "Status 󰂲 from A1..."
      fi
    '')
  ];
}
