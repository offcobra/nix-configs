# Wally's Nix-Configs

## Description

This Repository should serve as a starting / inspiration point for people intrested in the world of Nix / NixOS...

---

## Installation

This short Documentation should list the needed steps for a proper installation of this repo.

Starting Point:
- Install required Packages
    - NixOs
    - Home-manager (some other Distro)
- Post Install

### NixOs

#### Flake Install

- Add the following line to /etc/nixos/configuration.nix to install flakes.

```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

- After the line is added. Save and close the file.

```nix
cd /etc/nixos
sudo nixos-rebuild switch
```


#### Home-Manager (some other Distro)

- To install the Home-Manager as a stand-alone Module, execute the following code.

```nix
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update
sudo nix-shell '<home-manager>' -A install
```

- Now clone the repository and run the install commands

```nix
cd ~/.config/nixos
sudo nixos-rebuild --flake . switch
home-manager --flake . switch
```

- Reboot your system...


### Post Install

- After a successfull install & reboot, the following commands can be used to update / install NixOs & Home-Manager Modules.

```nix
os_rebuild    # -> For updateing & rebuild NixOs configs
hm_rebuild    # -> For rebuilding Home-Manager configs
```

---

## Various Stuff...

### Todo's for a better System:

- Repo Documnetation
    - install
    - packages (cli / ui)
- Remaining TODO's

---

## Special Thanks

(In no particular Order...)

    - LibrePhoenix: https://github.com/librephoenix/nixos-config
    - Titus tech
    - Distrotube


---

## Usefull links:
 - https://github.com/lutris/docs/blob/master/InstallingDrivers.md
 - https://nixos.wiki/wiki/AMD_GPU
