{ pkgs, userSettings, ... }:

{
  # List of secondary Applications
  home.packages = with pkgs; [
    nh
    # Rust cli tools
    fd
    eza
    procs
    lolcat
    du-dust
    ripgrep
    # More tools
    htop
    tealdeer
    curl
    wget
    killall
    ventoy
    pciutils
    copyq
    bottom
    macchina
    # cli tools
    cloc
    dysk
    unzip
    git-filter-repo

    # Programming languages
    # Haskell / C++ / Rust
    #ghc
    #rustup
    #gcc
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
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batwatch
      ];
    };
  };
}
