{ pkgs, userSettings, ... }:

{
  # List of secondary Applications
  home.packages = with pkgs; [
    nh
    # Rust cli tools
    fd
    eza
    procs
    zoxide
    lolcat
    du-dust
    ripgrep
    starship
    # More tools
    htop
    tealdeer
    curl
    wget
    killall
    ventoy
    pciutils
    copyq
    # cli tools
    cloc
    distrobox
    k3d
    dysk
    unzip
    # Haskell
    #ghc
    # Rust + Programs
    #rustup
    gcc
    bottom
    macchina
    # git stuff
    git-filter-repo

    # Python
    (python3.withPackages (ps: [
      ps.pip ps.psutil ps.qtile
    ]))
    jq
    pylint

    # Shell Scripts
    (writeShellScriptBin "airplane-mode" ''
      #!/bin/sh
      connectivity="$(nmcli n connectivity)"
      if [ "$connectivity" == "full" ]
      then
          notify-send -t 2000 "Network Status" "[CRITICAL] Airplane Mode: ON !!!"
          nmcli n off
      else
          notify-send -t 2000 "Network Status" "[CRITICAL] Airplane Mode: OFF !!!"
          nmcli n on
      fi
    '')
  ];

  programs = {
    # Vim Settings
    vim = {
      enable = true;
      settings = {
        expandtab = true;
        shiftwidth = 4;
        tabstop = 4;
      };
      extraConfig = ''
        syntax enable
        set incsearch
        set hlsearch
        set autoindent
        set number relativenumber
        " Dracula Colors
        " packadd! dracula
        " colorscheme dracula
      '';
    };

    # Git Version Control
    git = {
      enable = true;
      userName = userSettings.name;
      userEmail = userSettings.email;
    };

    # Bat a Better Cat
    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "Dracula";
      };
    };
  };
}
