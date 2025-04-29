{ pkgs, nixvim, lib, allowed-unfree-packages, nix-colors, userSettings, ... }:

{
  imports =
    [ # Include other modules
      nix-colors.homeManagerModules.default

      # Import Nixvim
      nixvim.homeManagerModules.nixvim

      # Bash Config
      ./cli/shell.nix

      # Dev Tools
      # Container tools like docker / podman
      # need to be installed on the host distro...
      ./cli/dev-tools.nix
    ];
  colorScheme = nix-colors.colorSchemes.${userSettings.colorTheme};

  # Home Manager
  home.username = "${userSettings.username}";
  home.homeDirectory = "/home/${userSettings.username}/";
  home.stateVersion = "24.05"; # Please dont change

  # Linking Home Files
  home.file = {
    ".local/share/fonts".source = "${pkgs.nerd-fonts.fira-code}/share/fonts/truetype/NerdFonts";
  };

  nixpkgs.config = {
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowed-unfree-packages;
  };

  # Sessionvariables
  home.sessionVariables = {
    EDITOR="nvim";
    XKB_DEFAULT_LAYOUT = "de";
    VISUAL="vim";
    PAGER="bat --pager 'less'";
    NH_FLAKE="/home/${userSettings.username}/.config/nixos";
    SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS="0";
    LC_ALL="C.UTF-8";
    LANG="C.UTF-8";
    LANGUAGE="en_US.UTF-8";
    _ZO_DOCTOR="0";
    TMPDIR="/tmp";
    #http_proxy="http://10.111.47.10:8080/";
    #https_proxy="http://10.111.47.10:8080/";
    #HTTP_PROXY="http://10.111.47.10:8080/";
    #HTPPS_PROXY="http://10.111.47.10:8080/";
    #GIT_SSL_NO_VERIFY=1;
  };

  # SessionPath
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
  };
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
