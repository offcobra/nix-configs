# System Configs Documentation

## Structure

Folder Structure...
```bash
system
├── helper
│  ├── hyprland.nix
│  ├── locales.nix
│  ├── nix-settings.nix
│  ├── ollama.nix
│  ├── polkit.nix
│  ├── qtile.nix
│  ├── steam.nix
│  ├── system_packages.nix
│  └── virtualization.nix
├── mediatv
│  └── hardware-configuration.nix
├── mediatv.nix
├── system.md
├── thinkpad
│  └── thinkpad-hardware.nix
├── thinkpad.nix
├── workstation
│  ├── boot.nix
│  └── hardware-configuration.nix
└── workstation.nix
```


----

## List of System Configs

The declarative definitions of all the Systems that are managed with this Repository.


### Workstation

Main Playground... =>  [Workstation](workstation.nix)

##### Hardware:

- CPU: Ryzen 9 7950x
- RAM: 64GB DDR5
- GPU: AMD Radeon RX 6700 / Nvidia RTX 2080 Super (GPU Passthrough)
- a couple of SSD's
- 3 Monitors

##### Features:

- [Hyprland](helper/hyprland.nix)
- [Qtile](helper/qtile.nix)
- [Virtualization](workstation/boot.nix)
    - GPU Passthrough with looking-glass
    - Distrobox with podman Containers
- [Steam gameing..](helper/steam.nix)


### Thinkpad

All purpose Laptop... => [Thinkpad](thinkpad.nix)

##### Hardware:

- CPU: i5 10500
- RAM: 8GB DDR4
- GPU: Integrated
- SSD: 250 GB

##### Features:

- [Hyprland](helper/hyprland.nix)
- [Qtile](helper/qtile.nix)
- Distrobox with Podman


### MediaTV

Old Asus ROG used as MediaTV... => [MediaTV](mediatv.nix)

##### Hardware:

- CPU: i7 4700
- RAM: 16GB DDR4
- GPU: Integrated + Nvidia 680M
- SSD: 250 GB

##### Features:

- [Qtile](helper/qtile.nix)
- Distrobox with Podman
- Runs old Nvidia legacy drivers...


----

# Todo

Will be built...

### StudioPC

    - DesktopEnvironment: pantheon
    - Theme: WhiteSUR (GTK, Icon, Cursor ...)
    - Apps: Tenacity, ...

##### Hardware:

- CPU: Ryzen 5
- RAM: 16GB DDR4
- GPU: AMD Radeon RX 580x
- SSD: 250 GB

----
