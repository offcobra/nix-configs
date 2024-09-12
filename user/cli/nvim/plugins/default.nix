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
    #headlines.enable = true;

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

    # markdown viewer
    markview.enable = true;

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

    # Colorizer
    nvim-colorizer.enable = true;

    # Obsidian
    obsidian = {
      enable = true;
      settings = {
        completion = {
          min_chars = 2;
          nvim_comp = true;
        };
        dir = "/home/ppuscasu/obsidian";
        notes_subdir = "notes";
        new_notes_location = "notes_subdir";
      };
    };

    # Ollama Ai
    ollama = {
      enable = true;
      url = "http://127.0.0.1:11434";
    };

    # find project from .git files
    project-nvim = {
      enable = true;
      enableTelescope = true;
      settings.scope_chdir = "win";
    };

    # Surround
    surround.enable = true;

    # Todo-Comments
    todo-comments.enable = true;

    # nvim terminals
    toggleterm = {
      enable = true;
      settings = {
        hide_numbers = true;
        autochdir = true;
        shell = "fish";
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

    # yanky Clipboard
    yanky = {
      enable = true;
      enableTelescope = true;
    };

    # PopUp to show keybindings
    which-key.enable = true;

    # Menu for modes
    wilder = {
      enable = true;
      modes = [ ":" "/" "?" ];
    };

    # Zen mode
    zen-mode.enable = true;
  };
}
