{ userSettings, ... }:

let
  update_cmd = if (userSettings.username == "wally")
      then "flatpak update -y && os_rebuild && hm_rebuild && nix_clean"
      else "sudo pacman -Syyu && nh home switch --update && nix_clean";
  keep = if (userSettings.username == "wally") then "3" else "2";

  # Shell aliases
  aliases = {
    # Movement
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";

    # Utilities
    df = "dysk";
    find = "fd --hidden";
    grep = "rg -i";
    du = "dust";
    ps = "procs";
    cat = "bat";
    cat1 = "/run/current-system/sw/bin/cat";
    brc = "source ~/.bashrc";
    gping ="ping www.google.com";
    dcal = "date && cal -3";
    my_pub_ip = "curl icanhazip.com";
    pdf = "zathura";
    img = "loupe";

    # List dir
    tree = "eza --tree -a";
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
    nix_clean="nh clean user --keep ${keep}";

    # Ollama AI Chat
    ai="ollama run llama3.1";

    # Update whole System
    update = "${update_cmd}";
  };
in
{
  imports = [
    # Adding cli app configs
    ./macchina/macchina.nix
    # Adding starship config
    ./starship.nix
    # Adding tools
    ./tools.nix
    # fzf
    ./fzf.nix
    # tmux
    ./tmux.nix
    # NixVim
    ./nvim
    # zoxide configs
    ./zoxide.nix
    # Scripts
    ./scripts/helper.nix
  ];
  # Session Shells
  programs = {
    bash = {
      enable = true;
      shellAliases = aliases;
      historySize = 10000;
      shellOptions = [
        "histappend"
        "checkwinsize"
      ];
      historyControl = [
        "erasedups"
        "ignoredups"
        "ignorespace"
      ];
      bashrcExtra = "
# Make $HOME default
cd $HOME

# Set vi mode
set -o vi

# Added by Nix installer
if [ -e /home/${userSettings.username}/.nix-profile/etc/profile.d/nix.sh ]
then
    . /home/${userSettings.username}/.nix-profile/etc/profile.d/nix.sh
fi

# Start WindowManager
start-wm

# Prompt Aliases Custom for local & docker
macchina
# TODO fix me...
# where-am-i
      ";
    };

    # Fish configs
    fish = {
      enable = true;
      shellAliases = aliases;
      interactiveShellInit = ''
        set fish_greeting                     # Disable greeting
        fish_vi_key_bindings                  # Set vi mode
        zoxide init --cmd j fish | source     # Activate zoxide (better cd)
        starship init fish | source           # Starship -> better prompt
        macchina                              # Minimal fastfetch
      '';
    };
  };
}
