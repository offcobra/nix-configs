{ pkgs, userSettings, ... }:

{
  # List of secondary Applications
  home.packages = with pkgs; [
    # Nix helper
    nh

    # Rust cli tools
    fd
    eza
    dysk
    procs
    lolcat
    du-dust
    ripgrep
    tealdeer

    # Virt / Container tools
    k3d
    kubectl
    distrobox
    kubernetes-helm

    # Network
    dig
    nmap
    curl
    wget
    whois
    rustscan
    traceroute

    # More tools
    htop
    killall
    ventoy
    pciutils
    bottom
    macchina
    clipman

    # cli tools
    jq
    cloc
    unzip
    git-filter-repo

    # Programming languages
    # Python
    (python3.withPackages (ps: [
      ps.pip
      ps.pylint
    ]))

    # Haskell / C++ / Rust
    #ghc
    #rustup
    #gcc
  ];

  programs = {

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

    # Newsfeed
    # TODO add theme + feeds...
    newsboat = {
      enable = true;
      urls = [
        {
          tags = [ "Linux" ];
          url = "https://archlinux.org/feeds/news/";
        }
      ];
    };
  };
}
