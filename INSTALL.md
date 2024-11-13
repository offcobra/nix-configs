# Installation

This short Documentation should list the needed steps for a proper installation of this repo.


>! Critical !!!
>
> The Installation Steps may vary depending on your Configuration...


## Starting Point:

- Install
    - NixOs
    - Home-manager (some other Distro)
- Post Install


## NixOs

### Flake Install

- Add the following line to /etc/nixos/configuration.nix to install flakes.

```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

- After the line is added. Save and close the file.

```bash
cd /etc/nixos
sudo nixos-rebuild switch
```


### Home-Manager (some other Distro)

- To install the Home-Manager as a stand-alone Module, execute the following code.

```bash
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update
sudo nix-shell '<home-manager>' -A install
```

- Now clone the repository and run the install commands

```bash
cd ~/.config/nixos
sudo nixos-rebuild --flake . switch
home-manager --flake . switch
```

- Reboot your system...


## Post Install

- After a successfull install & reboot, the following commands can be used to update / install NixOs & Home-Manager Modules.

```bash
os_rebuild    # -> For updateing & rebuild NixOs configs
hm_rebuild    # -> For rebuilding Home-Manager configs
```

---
