{ ... }:

{
  # nvim Completions
  programs.nixvim.plugins = {

    # Comp Plugins
    luasnip.enable = true;
    cmp-buffer.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp-path.enable = true;
    cmp_luasnip.enable = true;
    cmp-cmdline.enable = true;

    cmp = {
      enable = true;
      #autoEnableSources = true;
      settings = {
        experimental = {
          ghost_text = true;
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "pyright"; }
          { name = "luasnip"; }
          { name = "buffer"; }
          { name = "path"; }
        ];
        mapping = {
  		__raw = ''
            cmp.mapping.preset.insert({
              ['<C-j>'] = cmp.mapping.select_next_item(),
              ['<C-k>'] = cmp.mapping.select_prev_item(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }),
              ['<S-CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
            })
          '';
        };
  	  performance = {
  		debounce = 60;
  		fetching_timeout = 200;
  	    max_view_entries = 30;
  	  };
  	  window = {
          completion = {
            border = "rounded";
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None";
          };
          documentation = {
            border = "rounded";
          };
        };
        formatting = {
          fields = ["kind" "abbr" "menu"];
          expandable_indicator = true;
        };
      };
    };
    helm.enable = true;
  };
}
