{ ... }:

{
  # Flatpaks declarative
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
      "org.qutebrowser.qutebrowser"
    ];
    uninstallUnmanaged = true;
    update.onActivation = true;
  };

}
