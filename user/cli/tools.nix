{ config, pkgs, userSettings, ... }:

{
  # List of secondary Applications
  home.packages = with pkgs; [
    ventoy
    pciutils
    # cli tools
    distrobox
    fzf
    k3d
    dysk
    # Haskell
    ghc
    # Rust + Programs
    rustup
    bottom
    macchina
    # Python
    (python3.withPackages (ps: [ ps.pip ps.psutil ]))
    # Shell Scripts
    (pkgs.writeShellScriptBin "airplane-mode" ''
      #!/bin/sh
      connectivity="$(nmcli n connectivity)"
      if [ "$connectivity" == "full" ]
      then
          nmcli n off
      else
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
