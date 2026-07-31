# Aspect: apps -- GUI apps (brave, freetube, zathura, imv, terminals) plus the
# per-host desktop package set. Leaf reads systemSettings.hostname (bridged).
{
  flake.modules.homeManager.apps = {
    imports = [ ./_src/apps/apps.nix ];
  };
}
