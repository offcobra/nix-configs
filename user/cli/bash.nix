{ config, pkgs, ... }:

{
  imports = [
    # Adding cli app configs
    ./macchina/macchina.nix
    # Adding starship config
    ./starship.nix
    # Adding tools
    ./tools.nix
  ];
  # Session Aliases
  programs.bash.enable = true;
  programs.bash.shellAliases = {

    # Movement
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";

    # Utilities
    df = "dysk";
    find = "fd";
    grep = "rg";
    du = "dust";
    ps = "procs";
    cat1 = "/run/current-system/sw/bin/cat";
    brc = "source ~/.bashrc";
    gping ="ping www.google.com";
    dcal = "date && cal 2024";
    my_pub_ip = "curl icanhazip.com";
    pdf = "evince";
    img = "viewnior";

    # List dir
    tree = "eza --tree";
    ll = "eza -la --color=always --group-directories-first --group --icons";
    la = "eza -a --color=always --group-directories-first --group --icons";
    lt = "eza -aT --color=always --group-directories-first";
    ls = "eza --color=always --group-directories-first --icons";

    # Git
    g = "git";
    gp = "git pull";
    ga = "git add";
    gs = "git status";
    gc = "git checkout";
    dog = "git log --oneline --graph --decorate --all";
    git_clean = "git remote update origin --prune";

    # Nixos Rebuild
    os_rebuild="nh os switch --update --ask";
    hm_rebuild="nh home switch";
    nix_clean="nh clean all --keep 3";
    
    # Update whole System
    update="distrobox upgrade arch && flatpak update -y && os_rebuild && hm_rebuild";
  };

  programs.bash.bashrcExtra = "
# Source Helper Functions
source /home/wally/.local/bin/helper.sh 

# Start WindowManager
start_wm

# Prompt 6 Aliases Custom for local & docker
where_am_i
  ";
  programs.bash.historySize = 10000;
  programs.bash.shellOptions = [
    "histappend"
    "checkwinsize"
  ];
  programs.bash.historyControl = [
    "erasedups"
    "ignoredups"
    "ignorespace"
  ];
}

