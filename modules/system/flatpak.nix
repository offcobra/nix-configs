# Aspect: flatpak -- declarative Flatpak via nix-flatpak.
{ inputs, ... }:
{
  flake.modules.nixos.flatpak =
    { pkgs, ... }:
    {
      imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

      xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        config.common.default = "*";
      };

      services.flatpak = {
        enable = true;
        remotes = [{
          name = "flathub";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }];
        packages = [
          "com.github.tchx84.Flatseal"
          "com.rtosta.zapzap"
          "org.signal.Signal"
          "app.zen_browser.zen"
          "com.discordapp.Discord"
          "me.proton.Mail"
          "com.protonvpn.www"
          "me.proton.Pass"
          "org.gimp.GIMP"
          "com.bitwig.BitwigStudio"
        ];
        uninstallUnmanaged = true;
        update.onActivation = true;
      };
    };
}
