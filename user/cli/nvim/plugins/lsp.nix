{ ... }:

{
  programs.nixvim.plugins = {
    # Language Server Protocol LSP
    lsp = {
  	  enable = true;
  	  servers = {
  	    bashls.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        pyright.enable = true;
        #ruff.enable = true;
        jsonls.enable = true;
  	    yamlls.enable = true;
  	    lua_ls.enable = true;
  	    nixd.enable = true;
  	    helm_ls.enable = true;
        marksman.enable = true;
        terraformls.enable = true;
  	  };
      keymaps.lspBuf = {
        "gd" = {
          action = "definition";
          desc = "Goto Definition";
        };
        "gr" = {
          action = "references";
          desc = "Goto reference";
        };
        "gD" = {
          action = "declaration";
          desc = "Goto Declaration";
        };
        "gT" = {
          action = "type_definition";
          desc = "Type Definition";
        };
        "gI" = {
          action = "implementation";
          desc = "Goto Implementation";
        };
        "H" = {
          action = "hover";
          desc = "Hover";
        };
      };
    };

    # inject LSP diagnostics
    #none-ls = {
    #  enable = true;
    #  sources = {
    #    diagnostics = {
    #      #mypy.enable = true;
    #      ansiblelint.enable = true;
    #      pylint.enable = true;
    #    };
    #    formatting = {
    #      nixfmt.enable = true;
    #      shellharden.enable = true;
    #      yamlfmt.enable = true;
    #    };
    #  };
    #};
  };
}
