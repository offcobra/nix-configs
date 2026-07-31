# Aspect: wayland -- Wayland desktop bits that pair with Hyprland: the foot
# terminal (referenced by the hyprland keybinds) and the fuzzel launcher.
{
  flake.modules.homeManager.wayland = {
    imports = [
      ./_src/wayland/foot.nix
      ./_src/wayland/fuzzel.nix
    ];
  };
}
