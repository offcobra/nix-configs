{ pkgs, ... }:

{
  imports = [
    # Import Scripts
    # Websearch
    ./websearch.nix

    # Screen Layout Scripts
    ./screen_full.nix
    ./screen_chill.nix
    ./screen_work.nix

    # Window Manager (hyprland / qtile) kill Script
    ./kill_wm.nix

    # Show Time / Battery Info
    ./show_info.nix

    # Toggle process
    ./toggle_proc.nix

    # Toggle CPU Guvernor
    ./toggle_cpu.nix

    # Virt-Run (vms / pods) script ...
    ./virt_run.nix

    ./poker_equity.nix
  ];

  home.packages = with pkgs; [

    # ShellScript start-vm (graphical environment)
    (writeShellScriptBin "start-wm" ''
      if [[ $(cat /etc/hostname) == "mediatv" ]]
      then
          # Only for MediaTV
          startx
      else
          if [[ $(tty) == "/dev/tty1" ]] then
              # Start Hyprland
              Hyprland
          elif [[ $(tty) == "/dev/tty2" ]]
          then
              # Qtile start -b x11
              startx
          fi
      fi
    '')

    # ShellScript to extract all files
    (writeShellScriptBin "extract" ''
      if [ -f "$1" ] ; then
        case "$1" in
          *.tar.bz2)   tar xjf "$1"     ;;
          *.tar.gz)    tar xzf "$1"     ;;
          *.bz2)       bunzip2 "$1"     ;;
          *.rar)       unrar x "$1"     ;;
          *.gz)        gunzip "$1"      ;;
          *.tar)       tar xf "$1"      ;;
          *.tbz2)      tar xjf "$1"     ;;
          *.tgz)       tar xzf "$1"     ;;
          *.zip)       unzip "$1"       ;;
          *.Z)         uncompress "$1"  ;;
          *.7z)        7z x "$1"        ;;
          *.deb)       ar x "$1"        ;;
          *.tar.xz)    tar xf "$1"      ;;
          *.tar.zst)   tar xf "$1"      ;;
          *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
      else
        echo "'$1' is not a valid file"
      fi
    '')
  ];
}
