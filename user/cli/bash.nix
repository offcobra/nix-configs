{ userSettings, ... }:

let
  update_cmd = if (userSettings.username == "wally")
      then "flatpak update -y && os_rebuild && hm_rebuild"
      else "sudo pacman -Syyu && nh home switch --update";
  keep = if (userSettings.username == "wally") then "3" else "2";
in
{
  imports = [
    # Adding cli app configs
    ./macchina/macchina.nix
    # Adding starship config
    ./starship.nix
    # Adding tools
    ./tools.nix
    # Fish
    ./fish.nix
    # fzf
    ./fzf.nix
    # tmux
    ./tmux.nix
    # NixVim
    ./nvim
    # Dev Tools
    ./dev-tools.nix
    # zoxide configs
    ./zoxide.nix
    # Scripts
    ./scripts/helper.nix
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
    grep = "rg -i";
    du = "dust";
    ps = "procs";
    cat1 = "/run/current-system/sw/bin/cat";
    brc = "source ~/.bashrc";
    gping ="ping www.google.com";
    cal = "cal -3";
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

    # alacritty Config keybinding for wsl
    term-conf="vim /mnt/c/Users/${userSettings.username}/AppData/Roaming/Alacritty/alacritty.toml";
    glaze="vim /mnt/c/Users/${userSettings.username}/AppData/Roaming/Alacritty/glazewm.yaml";

    # Nixos Rebuild
    os_rebuild="nh os switch --update --ask";
    hm_rebuild="nh home switch";
    nix_clean="nh clean user --keep ${keep}";

    # Update whole System
    update = "${update_cmd}";
  };

  programs.bash.bashrcExtra = "
# Make $HOME default
cd $HOME

# Set vi mode
set -o vi

# Added by Nix installer
if [ -e /home/${userSettings.username}/.nix-profile/etc/profile.d/nix.sh ]; then . /home/${userSettings.username}/.nix-profile/etc/profile.d/nix.sh; fi

# Start WindowManager
start-wm

# Prompt Aliases Custom for local & docker
where-am-i
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
