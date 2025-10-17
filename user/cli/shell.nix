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
    d = "nvim -c Oil";
    f = "fd --hidden";
    c = "clear";
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
    cat1 = "bat --decorations never";
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
    nix-clean="nh clean all --keep ${keep}";

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

    # Homelab
    homelab = "ssh wally@192.168.122.2";
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
      shellInit = "
set --local profile ~/.nix-profile
set --local default /nix/var/nix/profiles/default

set --local channels ~/.nix-defexpr/channels
contains $channels $NIX_PATH || set --global --export --append NIX_PATH $channels

function _nix_install --on-event nix_install --inherit-variable profile
    set --universal --export NIX_PROFILES $profile

    if test -d $default && ! contains $default $NIX_PROFILES
        set --prepend NIX_PROFILES $default
    end

    # Also check for /etc/ssl/cert.pem, see https://github.com/NixOS/nix/issues/5461
    for file in /etc/{ssl/{certs/ca-certificates.crt,ca-bundle.pem,certs/ca-bundle.crt},pki/tls/certs/ca-bundle.crt,ssl/cert.pem} $profile/etc/{ssl/certs/,}ca-bundle.crt
        if test -e $file
            set --universal --export NIX_SSL_CERT_FILE $file
            break
        end
    end
end

function _nix_uninstall --on-event nix_uninstall
    set --erase NIX_{PATH,PROFILES,SSL_CERT_FILE}
    functions --erase _nix_{,un}install
end

test -n \"$MANPATH\" && set --prepend MANPATH $profile/share/man

set --local packages (string match --regex \"/nix/store/[\w.-]+\" $PATH)
fish_add_path --global --append $packages/bin $profile/bin $default/bin

if test (count $packages) != 0
    set fish_complete_path $fish_complete_path[1] \
        $packages/etc/fish/completions \
        $packages/share/fish/vendor_completions.d \
        $fish_complete_path[2..]
    set fish_function_path $fish_function_path[1] \
        $packages/etc/fish/functions \
        $packages/share/fish/vendor_functions.d \
        $fish_function_path[2..]

    for file in $packages/etc/fish/conf.d/*.fish $packages/share/fish/vendor_conf.d/*.fish
        if ! test -f (string replace --regex \"^.*/\" $__fish_config_dir/conf.d/ -- $file)
            source $file
        end
    end
end
      ";
    };
    lf = {
      enable = true;
    };
  };
}
