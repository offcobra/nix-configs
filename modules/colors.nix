# Aspect: colors -- nix-colors is the single source of truth for the palette.
#
# Any home aspect can now read `config.colorScheme.palette.baseXX` (see the
# hyprland border colors). The scheme name comes from the global constant.
{ inputs, config, ... }:
let
  c = config.constants;
in
{
  flake.modules.homeManager.colors = {
    imports = [ inputs.nix-colors.homeManagerModules.default ];
    colorScheme = inputs.nix-colors.colorSchemes.${c.colorTheme};
  };
}
