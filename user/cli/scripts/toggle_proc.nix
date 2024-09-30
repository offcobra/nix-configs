{ pkgs, ... }:

{
  home.packages = [
    # ShellScript to toggle specific Process...
    (pkgs.writeShellScriptBin "toggle-proc.sh" /*bash*/ ''
      process_name=$1
      echo "Process $process_name ..."
      notify-send -t 5000 "Process Toggle" "Toggling $process_name ..."

      # Check if the process is running
      if pgrep $process_name >/dev/null; then
          # Process is running, so kill it
          process_id=$(pgrep $process_name)
          kill -9 $process_id
          echo "Process $process_name killed."
      else
          # Process is not running, so start it
          $process_name >/dev/null 2>&1 &
          echo "Process $process_name started."
      fi
    '')
  ];
}
