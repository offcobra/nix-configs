{ config, pkgs, nixvim, ... }:

{
  # NeoVim Configs
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    # Aliases for vim
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    # Options
    options = {
      number = true;
      #relativnumber = true;

      shiftwidth = 4;
    };

    # Theme
    colorschemes.catppuccin = {
      enable = true;
      flavour = "macchiato";
    };

    # Plugins
    plugins = {
      bufferline.enable = true;
      lualine.enable = true;
      nix.enable = true;
      helm.enable = true;
      oil.enable = true;
      neogit.enable = true;
      nvim-autopairs.enable = true;
    };

    # Keymaps
    #globals.mapleader = " ";
    keymaps = [
      {
        mode = "n";
        action = "<cmd>Neogit<CR>";
        key = "<C-g>";
        options = {
          silent = true;
        };
      }
    ];
  };
}
