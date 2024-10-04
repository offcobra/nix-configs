{ pkgs, ... }:

let
  # Python Script to run Distro Container
  virt-run = pkgs.writers.writePython3Bin "virt-run.py" { } /*python*/''
    import argparse
    import os
    import subprocess


    PROGRAMMS = "git exa neofetch"

    # Define ENV Variables
    env_type = os.environ.get("XDG_SESSION_TYPE")
    if env_type == "wayland":
        DMENU = "fuzzel --dmenu"
        TERM = "foot"
    else:
        DMENU = "rofi --dmenu"
        TERM = "kitty"


    # Distros to run...
    DISTROS = {
        "apps": "   Apps",
        "alpine": "   Alpine",
        "arch": "   Arch Linux",
        "artix": "   Artix",
        "blackarch": "   BlackArch",
        "debian": "   Debian",
        "deepin": "   Deepin",
        "fedora": "   Fedora",
        "kali": "   Kali Linux",
        "mint": "󰣭   Mint",
        "nixos": "   NixOS",
        "opensuse": "   OpenSuse",
        "parrot": "   Parrot OS",
        "rocky": "   Rocky Linux",
        "ubuntu": "󰕈   Ubuntu",
        "vanila": "   VanilaOS",
        "win11": "   Windows",
        "zorin": "   ZorinOS",
    }


    DISTRO_IMAGES = {
        "alpine": "alpine:latest",
        "artix": "artixlinux/artixlinux:latest",
        "arch": "archlinux:latest",
        "blackarch": "blackarchlinux/blackarch",
        "debian": "debian:latest",
        "fedora": "fedora:latest",
        "kali": "kalilinux/kali-rolling:latest ",
        "opensuse": "opensuse/tumbleweed:latest",
        "parrot": "parrotsec/security:latest",
        "rocky": "rockylinux:latest",
        "ubuntu": "ubuntu:latest",
    }


    def get_args():
        """ Get cmd args... """
        parser = argparse.ArgumentParser(description="Process virt-run args.")
        parser.add_argument("--vms", type=str, help="VM options...")
        parser.add_argument("--pods", type=str, help="Pods options...")
        parser.add_argument("--info", action="store_true", help="Pods options...")
        parser.add_argument("--stop",
                            action="store_true",
                            help="Stop all Virtualization...")
        return parser.parse_args()


    def run_fuzzel(elem, cmd=DMENU):
        """ Function to run fuzzel... """
        output = subprocess.check_output(
          f"echo '{elem}' | {cmd}", shell=True
          ).decode("utf-8").replace("\n", "")
        return output


    def run_cmd(command, list=False):
        """ Function to run fuzzel... """
        output = subprocess.check_output(command, shell=True).decode("utf-8")
        if not list:
            return output.replace("\n", "")
        return [elem for elem in output.split("\n") if elem != ""]


    def send_notify(text, duration=2000):
        """ Function to send notifications... """
        run_cmd(f"notify-send -t {duration} 'Virt-Manager' '{text}'")


    def run_vms(name=""):
        """ Function to run vms """
        if not run_cmd("systemctl is-active libvirtd") == "active":
            run_cmd("systemctl start libvirtd")

        vms = run_cmd("virsh list --all --name", list=True)
        running = run_cmd("virsh list --all --name --state-running", list=True)

        distros = {}
        for vm in vms:
            if name in vm:
                name = vm
            short = "".join([x for x in DISTROS.keys() if vm.startswith(x)])
            if vm in running:
                distros[vm] = DISTROS[short] + " "*10 + "=> # Running..."
            else:
                distros[vm] = DISTROS[short]

        if name == "choice":
            choice = run_fuzzel("\n".join(distros.values()))
            vm_name = [k for k, v in distros.items() if v.startswith(choice)][0]
        else:
            vm_name = name

        print(f"# => Start / Attach to VM {vm_name}")
        send_notify(f"Starting / Attaching to {vm_name}...")
        if vm_name not in vms and vm_name != "choice":
            raise Exception(f"#=> No VM with name: {vm_name}...")

        if vm_name not in running:
            subprocess.run(f"virsh start '{vm_name}'", shell=True)

        # time.sleep(3)
        if vm_name == "win11":
            subprocess.run("looking-glass-client", shell=True)
        else:
            subprocess.run(f"virt-viewer -a '{vm_name}' -f", shell=True)


    def run_pods(name=""):
        """ Function to run pods """
        pods = run_cmd("podman ps --noheading", list=True)

        available_distros = {}
        for k, v in DISTROS.items():
            if k in DISTRO_IMAGES.keys():
                available_distros[k] = v

        if name == "choice":
            choice = run_fuzzel("\n".join(available_distros.values()))
            try:
                pod_name = [k for k, v in DISTROS.items() if v == choice][0]
            except IndexError:
                raise Exception(f"#=> Distro {name} no supported...")
        else:
            pod_name = name

        is_created = bool([line for line in pods if pod_name in line])

        send_notify(f"Starting / Attaching to {pod_name}...")
        if not is_created:
            run_cmd(f"{TERM} --title {pod_name} -e \
                distrobox create --name {pod_name} \
                --image {DISTRO_IMAGES[pod_name]} --pull"
                    )
        run_cmd(f"{TERM} --title {pod_name} -e distrobox enter {pod_name}")


    def main():
        """ Main Function """
        args = get_args()

        if args.vms:
            run_vms(args.vms)

        if args.pods:
            run_pods(args.pods)

        if args.stop:
            send_notify("Stopping all Vms / Pods...")
            for vm in run_cmd("virsh list --state-running --name", list=True):
                run_cmd(f"virsh shutdown {vm}")
            run_cmd("podman stop --all -t=3")

        if args.info:
            vms = run_cmd("virsh list --state-running --name", list=True)
            pods = run_cmd("podman ps --format \"{{.Image}}\"", list=True)

            vm_icons = ""
            pod_icons = ""

            for vm in vms:
                vm = vm.split("=")[0]
                vm_icons += f" {DISTROS[vm].split(" ")[0]}"

            for key, value in DISTROS.items():
                for pod in pods:
                    if key in pod:
                        pod_icons += f" {DISTROS[key].split(" ")[0]}"

            if not vms and not pods:
                print("")
            else:
                vm_icons = " 󰜺" if not vm_icons else vm_icons
                pod_icons = " 󰜺" if not pod_icons else pod_icons
                print(f"Vms:{vm_icons} / Pods:{pod_icons}")


    if __name__ == "__main__":
        """ Entrypoint... """
        main()
'';
in
{
  home.packages = [virt-run];
}
