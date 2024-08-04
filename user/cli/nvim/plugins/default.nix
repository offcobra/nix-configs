{ ... }:

{
  imports = [

    # nvim Completions
    ./completions.nix

    # Language Server Protocol
    ./lsp.nix

    # Dashboard
    ./alpha.nix

    # File explorer
    ./oil.nix

    # fzf awsome tool
    ./telescope.nix

    # Project Tree
    ./neo-tree.nix

    # Git Client
    ./git.nix
  ];

  # Plugins
  programs.nixvim.plugins = {

    # auto-save Buffer
    auto-save.enable = true;

    # Shows open Tabs
    bufferline.enable = true;

    # Highlights for markdown / org files
    headlines.enable = true;

    # smart indent on Blankline
    indent-blankline = {
      enable = true;
      settings = {
        indent = {
          smart_indent_cap = true;
          char = " ";
        };
        scope = {
          char = "|";
        };
      };
    };

    # nvim StatusLine
    lualine.enable = true;

    # nix Support
    nix.enable = true;

    # better command prompt
    noice.enable = true;

    # notify daemon
    notify = {
      enable = true;
      topDown = true;
    };

    # autopair for coding
    nvim-autopairs.enable = true;

    # find project from .git files
    project-nvim = {
      enable = true;
      enableTelescope = true;
    };

    # nvim terminals
    toggleterm = {
      enable = true;
      settings = {
        hide_numbers = true;
        autochdir = true;
      };
    };

    # clears empty lines and widespaces
    trim = {
      enable = true;
      settings.highlight = false;
    };

    # treesitter config
    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
      };
    };

    # nvim debugger
    trouble.enable = true;

    # PopUp to show keybindings
    which-key.enable = true;

    # Menu for modes
    wilder = {
      enable = true;
      modes = [ ":" "/" "?" ];
    };
  };
}
