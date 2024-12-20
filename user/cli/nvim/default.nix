{ ... }:

{
  imports = [

    # nvim theme
    ./theme.nix

    # nvim Keybindings
    ./keybindings.nix

    # nvim plugins
    ./plugins
  ];

  # NeoVim Configs
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    # Aliases for vim
    viAlias = true;
    #vimAlias = true;
    vimdiffAlias = true;

    # Options
    opts = {
      number = true;
      #relativnumber = true;

      mouse = "r";

      conceallevel = 1;

      ignorecase = true;
      smartcase = true;

      tabstop = 4;
      shiftwidth = 4;
      softtabstop = 4;
      expandtab = true;

      cursorline = true;
      ruler = true;

      swapfile = false;
    };
    extraPython3Packages = p: [
      p.qtile
      p.pip
      p.psutil
    ];
  };
}
