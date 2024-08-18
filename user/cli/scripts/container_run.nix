{ pkgs, ... }:

{
  home.packages = with pkgs; [

    # ShellScript conatainer_run
    (writeShellScriptBin "container_run-nix" ''
      set -euo pipefail

      # Define Variables
      DMENU="fuzzel --dmenu"

      declare -A array

      PROGRAMMS="git exa neofetch"

      array[   Alpine]="alpine"
      array[󰕈   Ubuntu]="ubuntu"
      array[   Debian]="debian"
      array[   Fedora]="fedora"
      array[   Kali Linux]="kali"
      array[   Arch Linux]="arch"
      array[   BlackArch]="blackarch"
      array[   Rocky Linux]="rocky"
      array[   Parrot OS]="parrot"
      array[   OpenSuse]="opensuse"
      array[   Apps]="apps"

      # Function to start Container
      start_distro() {
          echo "Starting $1 ..."
          notify-send -t 3000 "DistroBox" "Starting $1 ..."
          #alacritty  --title "$1" -e distrobox enter $1
          foot --title "$1" -e distrobox enter $1
      }

      install_distro() {
          local distro=$1
          echo "Installing Distro $distro in Container ...!"
          notify-send -t 5000 "DistroBox" "Installing $distro..."
          case $distro in
              alpine )
                  INSTALL_CMD="apk add $PROGRAMMS"
                  IMAGE=alpine:latest
                  ;;
              arch )
                  INSTALL_CMD="pacman -S archlinux-keyring --noconfirm"
                  IMAGE=archlinux:latest
                  ;;
              blackarch )
                  INSTALL_CMD="pacman -S $PROGRAMMS --noconfirm"
                  IMAGE=blackarchlinux/blackarch
                  ;;
              fedora )
                  #INSTALL_CMD="dnf install -y $PROGRAMMS"
                  INSTALL_CMD="sudo dnf install -y eza git neofetch fastfetch"
                  IMAGE=fedora:latest
                  ;;
              rocky )
                  INSTALL_CMD="dnf install -y git"
                  IMAGE=rockylinux:latest
                  ;;
              opensuse )
                  INSTALL_CMD="zypper install -y $PROGRAMMS"
                  IMAGE=opensuse/tumbleweed:latest
                  ;;
              kali )
                  INSTALL_CMD="apt install -y $PROGRAMMS kali-linux-headless"
                  IMAGE=kalilinux/kali-rolling:latest
                  ;;
              parrot )
                  INSTALL_CMD="apt install -y $PROGRAMMS"
                  IMAGE=parrotsec/security:latest
                  ;;
              nixos )
                  INSTALL_CMD="nix-shell -p $PROGRAMMS"
                  IMAGE=nixos/nix:latest
                  ;;
              apps )
                  INSTALL_CMD="pacman -S $PROGRAMMS --noconfirm"
                  IMAGE=archlinux:latest
                  ;;
              * )
                  INSTALL_CMD="apt install -y $PROGRAMMS"
                  IMAGE=$distro:latest
                  ;;
          esac
          distrobox create --image $IMAGE --name $distro --pull --init-hooks "$INSTALL_CMD"
          echo "Distro $distro installed in Container!"
      }

      main() {
          #notify-send -t 3000 "DistroBox" "Script has been called ..."
          echo "Check / activate Docker Service ..."

          INPUT=\$\{1:-}

          if [[ -z \$\{INPUT} ]]
          then
              image=$(printf '%s\n' "\$\{!array[@]}" | sort | \$\{DMENU} 'Choose Distro Image:' "$@") || exit 1
              distro="\$\{array["\$\{image}"]}"
          else
              distro=$INPUT
          fi

          if [[ $(docker ps -q -f name=$distro) ]]
          then
              start_distro $distro
          else
              install_distro $distro && start_distro $distro
          fi

          echo "Distro-run Script finished!"
      }

      [[ "\$\{BASH_SOURCE[0]}" == "$0" ]] && main "$@"
    '')
  ];
}
