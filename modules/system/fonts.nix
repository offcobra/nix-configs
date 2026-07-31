# Aspect: fonts.
{
  flake.modules.nixos.fonts =
    { pkgs, ... }:
    {
      fonts.packages = with pkgs; [
        nerd-fonts.fira-code
        nerd-fonts.inconsolata
        nerd-fonts.sauce-code-pro
      ];
    };
}
