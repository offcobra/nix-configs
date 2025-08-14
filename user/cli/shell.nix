{ userSettings, ... }:

let
  update_cmd = if (userSettings.username == "wally")
      then "os-rebuild && hm-rebuild && nix-clean"
      else "paru -Syyu --noconfirm && nh home switch --update && nix-clean";
  keep = if (userSettings.username == "wally") then "3" else "2";

  # Shell aliases
  aliases = {
    # Movement
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";

    # Utilities
    n = "nvim";
    df = "dysk";

    f = "fd --hidden";
    gr = "rg -i";
    pf = "fzf --preview='bat --color=always {}' | xargs nvim";
    pg = "rg --files-with-matches -i";
    find = "fd --hidden";
    pfind = "fzf --preview='bat --color=always {}' | xargs nvim";
    pgrep = "rg --files-with-matches -i";
    grep = "rg -i";
    du = "dust";
    ps = "procs";
    cat = "bat";
    cat1 = "/run/current-system/sw/bin/cat";
    dcal = "date && cal -3";
    my_pub_ip = "curl icanhazip.com";
    diff = "batdiff";
    man = "batman";

    # Media Stuff
    pdf = "zathura";
    img = "chafa";
    images = "loupe";

    # Shell reload
    brc = "source ~/.bashrc";
    frc = "source ~/.config/fish/config.fish";

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
    git-clean = "git remote update origin --prune";

    # python json parser
    boom = "python -m json.tool";

    # Nixos Rebuild
    os-rebuild="nh os switch --ask --update";
    hm-rebuild="nh home switch";
    nix-clean="nh clean user --keep ${keep}";

    # Ollama AI Chat
    ai="ollama run gemma3:latest";
    ai-big="ollama run llama3.3";

    # Update whole System
    update = "${update_cmd}";

    # Update Arch mirror
    umirror="sudo reflector --country Germany --sort score -f 10 -l 100 --save /etc/pacman.d/mirrorlist";

    # Testing commands...
    gping = "ping www.google.com";
    mic = "arecord -vvv -f dat /dev/null";
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
    # df - file manager
    ./lf.nix
    # tmux
    ./tmux.nix
    # NixVim
    ./nvim
    # zoxide configs
    ./zoxide.nix
    # Scripts
    ./scripts/helper.nix
    # Kubectl
    ./kubectl
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

# Kubecolor
source <(kubectl completion bash)
complete -o default -F __start_kubectl k

# Add fubectl
[ -f .local/bin/fubectl.source ] && source .local/bin/fubectl.source

# Start WindowManager
start-wm

# Pretty Shell
if [ -z $CONTAINER_ID ]
then
  macchina
fi
      ";
    };

    # Fish configs
    fish = {
      enable = true;
      shellAliases = aliases;
      interactiveShellInit = ''
        set fish_greeting                     # Disable greeting
        fish_vi_key_bindings                  # Set vi mode
        macchina                              # Minimal fastfetch
      '';
    };
    lf = {
      enable = true;
    };
  };
}
