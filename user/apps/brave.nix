{ pkgs, ... }:

{
  # Brave Browser Config
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden-desktop
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vinuium
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark-reader
      { id = "fjoaledfpmneenckfbpdfhkmimnjocfa"; } # nordvpn
    ];
    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform-hint=auto"
      #"--ozone-platform=auto"
      #"--disable-features=WebRtcAllowInputVolumeAdjustment"
    ];
  };
}
