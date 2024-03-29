{ config, pkgs, ... }:

{
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
    # List dir
    tree = "eza --tree";
    ll = "eza -la --color=always --group-directories-first --group --icons";
    la = "eza -a --color=always --group-directories-first --group --icons";
    lt = "eza -aT --color=always --group-directories-first";
    ls = "eza --color=always --group-directories-first --icons";
    # Git
    g = "git";
    dog = "git log --oneline --graph --decorate --all";
    git_clean = "git remote update origin --prune";
    # Nixos Rebuild
    update="sudo nix flake update $HOME/.config/nixos/";
    hm_rebuild="home-manager switch --flake $HOME/.config/nixos/";
    os_rebuild="sudo nixos-rebuild switch --flake $HOME/.config/nixos/";
  };
  programs.bash.bashrcExtra = "
# Source Helper Functions
source /home/wally/.local/bin/helper.sh 

# Start WindowManager
start_wm

# Prompt 6 Aliases Custom for local & docker
where_am_i
  ";
}

