{ userSettings, pkgs, ...}:

{
  # Sddm Theme
  environment.systemPackages = [
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      accent = "mauve";
      font  = userSettings.font;
      fontSize = "9";
      clockEnabled = true;
      background = "../../user/wallpapers/midnight-sea.jpg";
      loginBackground = true;
    })
    pkgs.sddm-sugar-dark
  ];

  # Sddm Service
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-mocha-mauve";
    #theme = "sugar-dark";
    #settings = {
    #  Autologin = {
    #    Session = "hyprland";
    #    User = "wally";
    #  };
    #};
  };
}
