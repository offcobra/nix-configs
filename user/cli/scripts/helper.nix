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

    # Hyprland kill Script
    ./kill_hyprland.nix
  ];

  home.packages = with pkgs; [

    # ShellScript start-vm (graphical environment)
    (writeShellScriptBin "start-wm" ''
      if [[ $(tty) == "/dev/tty1" ]]
      then
	      # Start Hyprland
	      Hyprland
      elif [[ $(tty) == "/dev/tty2" ]]
      then
	      # Qtile start -b x11
	      startx
      fi
    '')

    # ShellScript where-am-i
    (writeShellScriptBin "where-am-i" ''
      if [ -z "$container" ]
      then
        macchina
      else
        case $CONTAINER_ID in
          arch) DISTRO="" ;;
          ubuntu) DISTRO="" ;;
          parrot) DISTRO="" ;;
          debian) DISTRO="" ;;
          fedora) DISTRO="" ;;
          kali) DISTRO="" ;;
          alpine) DISTRO="" ;;
          apps) DISTRO="" ;;
          *) DISTRO="" ;;
        esac
        export MOZ_ENABLE_WAYLAND=1
        PS1="\n \[\033[1;34m\]$DISTRO \[\e[31m\]$CONTAINER_ID\n \[\033[1;36m\]\W >\[\033[1;34m\]>\[\033[0m\] "
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
