# My Shell Documentation

Short Documentation for my shell Environment.

Currently 2 Shells installed:
- `Bash`
- `Fish`

## Tools

1. macchina (fastfetch replacement)
2. starship (prompt PS1)
3. fzf (fuzzy finder)
4. tmux (multiplexer)
5. zoxide (better cd command)
6. NVim (NixVim => Main Editor)

    => Some more [Tools](user/cli/tools.nix)


## Shell Aliases

```Bash
    # Movement
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";

    # Utilities
    df = "dysk";
    #find = "fd --hidden";
    find = "fzf --preview='bat --color=always {}' | xargs nvim";
    grep = "rg --files-with-matches -i";
    du = "dust";
    ps = "procs";
    cat = "bat";
    cat1 = "/run/current-system/sw/bin/cat";
    gping ="ping www.google.com";
    dcal = "date && cal -3";
    my_pub_ip = "curl icanhazip.com";
    diff = "batdiff";
    man = "batman";

    # Media Stuff
    pdf = "zathura";
    img = "loupe";

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
    git_clean = "git remote update origin --prune";

    # Nixos Rebuild
    os_rebuild="nh os switch --ask";
    hm_rebuild="nh home switch";
    nix_clean="nh clean user --keep ${keep}";

    # Ollama AI Chat
    ai="ollama run llama3.2";

```

More definitions & configs in [Shell Stuff](user/cli/shell.nix) .

## Helper Functions

This are so usefull helper funtions in `Bash` => [Helper](user/cli/helper.nix)

---
