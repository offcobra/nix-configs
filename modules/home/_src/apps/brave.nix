{ pkgs, ... }:

{
  # Brave Browser Config
  programs.brave = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "epcnnfbjfcgphgdmggkamkmgojdagdnn"; }    # ublock origin
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; }    # vimium
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; }    # dark-reader
      { id = "jplgfhpmjnbigmhklmmbgecoobifkmpa"; }    # proton-vpn
      { id = "ghmbeldphafepmbegfdlkpapadhbakde"; }    # proton-pass
      #"fjoaledfpmneenckfbpdfhkmimnjocfa"    # nordvpn
      # "nngceckbapebfimnlniiiahkandclblb"  # bitwarden-desktop
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
