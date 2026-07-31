# Aspect: theme -- GTK/Qt/cursor theming. Leaf reads userSettings (bridged from
# constants) and config.colorScheme (from the colors aspect).
{
  flake.modules.homeManager.theme = {
    imports = [ ./_src/theme.nix ];
  };
}
