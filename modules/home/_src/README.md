# User Space Documentation

Everything that is installed in the User Space.


There are 2 Home-Manager Modules in the User Space. (home.nix & wsl.nix)

- `home.nix` => Used on every **NixOS** Maschine

- `wsl.nix` => Used on Windows in wsl2


## Table of content:

- Apps      => [Applications for bought X11 & Wayland](/user/apps/README.md)
- Wayland   => [Hyprland Ecosystem](/user/wayland/README.md)
- X11       => [Qtile WindowManager](/user/x11/README.md)
- shell     => [Shell Documentation](/user/cli/README.md)
- nvim      => [NixVim](/user/cli/nvim/README.md)


>! Important
>
> NixVim is the Main Editor of this Configs!

---

## Structure

```sh
user
├── apps                # Apps for X11 && Wayland
│  ├── alacritty.nix
│  ├── apps.nix
│  ├── brave.nix
│  ├── dunst.nix
│  ├── emacs.nix
│  ├── freetube.nix
│  ├── imv.nix
│  ├── kitty.nix
│  ├── qutebrowser.nix
│  ├── wezterm.nix
│  └── zathura.nix
├── cli                 # Shell Stuff
│  ├── dev-tools.nix
│  ├── fzf.nix
│  ├── macchina
│  ├── nvim             # NixVim (Main Editor)
│  ├── scripts
│  ├── shell.nix
│  ├── starship.nix
│  ├── tmux.nix
│  ├── tools.nix
│  └── zoxide.nix
├── home.nix
├── theme.nix
├── user.md
├── wallpapers
├── wayland             # Hyprland (wayland) Ecosystem
│  ├── foot.nix
│  ├── fuzzel.nix
│  ├── hypridle.nix
│  ├── hyprland.nix
│  ├── hyprlock.nix
│  ├── hyprpaper.nix
│  ├── pyprland.nix
│  ├── waybar.nix
│  └── wlogout
├── wsl.nix
└── x11                 # Qtile (X11) Environment
   ├── nitrogen.nix
   ├── picom.nix
   ├── qtile
   ├── qtile.nix
   └── rofi.nix
```
