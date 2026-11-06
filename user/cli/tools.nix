{ pkgs, userSettings, ... }:

{
  # Enable distrobox
  programs.distrobox.enable = true;

  # List of secondary Applications
  home.packages = with pkgs; [
    # Nix helper
    nh
    cowsay
    cava

    # Rust cli tools
    fd
    eza
    dysk
    procs
    lolcat
    dust
    ripgrep
    tealdeer

    # GO cli tools
    duf
    gdu

    # pdf
    pdftk

    # crypto
    cointop

    # viu or chafa
    # for terminal image rendering
    chafa

    # Virt / Container tools
    #distrobox

    # Network
    dig
    nmap
    curl
    wget
    whois
    rustscan
    traceroute
    iproute2
    openssh

    # More tools
    htop
    killall
    #ventoy
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
    python3
  ];

  programs = {

    # Git Version Control
    git = {
      enable = true;
      settings = {
        user = {
          name = userSettings.name;
          email = userSettings.email;
        };
      };
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
