{ pkgs, ... }:

let
  # Python Script to run Distro Container
  container-run = pkgs.writers.writePython3Bin "container-run.py" { } /*python*/''
    import os
    import subprocess
    import sys

    PROGRAMMS = "git exa neofetch"

    # Define ENV Variables
    env_type = os.environ['XDG_SESSION_TYPE']
    if env_type == "wayland":
      DMENU = "fuzzel --dmenu"
      TERM = "foot"
    else:
      DMENU = "rofi --dmenu"
      TERM = "kitty"

    # Distros to run...
    DISTROS = {
      "   Apps" = "apps",
      "   Alpine" = "alpine",
      "   Arch Linux" = "arch",
      "   Artix" = "artix",
      "   BlackArch" = "blackarch",
      "   Debian" = "debian",
      "   Fedora" = "fedora",
      "   Kali Linux" = "kali",
      "󰣭   Mint" = "mint",
      "   NixOS" ="nixos",
      "   OpenSuse" = "opensuse",
      "   Parrot OS" = "parrot",
      "   Rocky Linux" = "rocky",
      "󰕈   Ubuntu" = "ubuntu",
      "   VanilaOS" = "vanila",
      "   Windows" = "win11",
      "   ZorinOS" = "zorin",
    }


    def run_fuzzel(elem, cmd=DMENU):
      """ Function to run fuzzel... """
      output = subprocess.check_output(
        f"echo '{elem}' | {cmd}", shell=True
        ).decode("utf-8").replace("\n", "")
      return output


    def main():
      """ Main Function """
      if not sys.argv[1] in DISTROS.values():
        raise Exception('Distro not defined... or unsupported!!!')

      search = "\n".join(DISTROS.keys())
      distro = run_fuzzel(search)



      subprocess.run([BROWSER, search_query], check=True)


    if __name__ == '__main__':
        main()
    '';
in
{
  home.packages = [container-run];
}

# TODO
# - Add start or create container...
# - Check for Vm & start vm...
