{ pkgs, ... }:

{
  # Brave Browser Config
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "nngceckbapebfimnlniiiahkandclblb" # bitwarden-desktop
      "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark-reader
      "fjoaledfpmneenckfbpdfhkmimnjocfa" # nordvpn
      "jplgfhpmjnbigmhklmmbgecoobifkmpa" # proton-vpn
      "ghmbeldphafepmbegfdlkpapadhbakde" # proton-pass
    ];
    #commandLineArgs = [
    #  "--enable-features=UseOzonePlatform"
    #  "--ozone-platform-hint=auto"
    #  #"--ozone-platform=auto"
    #  #"--disable-features=WebRtcAllowInputVolumeAdjustment"
    #];
    #extraOpts = {
    #  "BrowserSignin" = 0;
    #  "SyncDisabled" = true;
    #  "PasswordManagerEnabled" = false;
    #  "SpellcheckEnabled" = true;
    #  "SpellcheckLanguage" = [
    #    "de"
    #    "en-US"
    #  ];
    #};
  };
}
