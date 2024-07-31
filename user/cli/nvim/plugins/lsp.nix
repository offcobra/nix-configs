{ ... }:

{
  programs.nixvim.plugins = {
    # Language Server Protocol LSP
    lsp = {
  	  enable = true;
  	  servers = {
  	    bashls.enable = true;
  	    rust-analyzer.enable = true;
        pylyzer.enable = true;
        #pylsp = {
        #  enable = true;
        #  settings.configurationSources = "pycodestyle";
        #};
        jsonls.enable = true;
  	    yamlls.enable = true;
  	    lua-ls.enable = true;
  	    nixd.enable = true;
  	    helm-ls.enable = true;
  	  };
      keymaps.lspBuf = {
        "<leader>hd" = "definition";
        "<leader>hD" = "references";
        "<leader>ht" = "type_definition";
        "<leader>hi" = "implementation";
        "<leader>hh" = "hover";
      };
    };

    # inject LSP diagnostics
    none-ls = {
      enable = true;
      sources = {
        diagnostics = {
          ansiblelint.enable = true;
          pylint.enable = true;
        };
        formatting = {
          nixfmt.enable = true;
          shellharden.enable = true;
          yamlfmt.enable = true;
        };
      };
    };
  };
}