{ ... }:

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

      ignorecase = true;
      smartcase = true;

      tabstop = 4;
      shiftwidth = 4;
      softtabstop = 4;
      expandtab = true;

      cursorline = true;
      ruler = true;
    };

    # Theme
    colorschemes.catppuccin = {
      enable = true;
      flavour = "macchiato";
      settings = {
	    no_bold = false;
	    no_italic = false;
	    no_underline = false;
	    integrations = {
	      cmp = true;
	      noice = true;
	      notify = true;
          neogit = true;
	      neotree = true;
	      which_key = true;
 	      treesitter = true;
	      telescope.enable = true;
	    };
      };
    };

    # Plugins
    plugins = {
      # Comp Plugins
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp-cmdline.enable = true;
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          experimental = {
            ghost_text = true;
          };
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

	  # Language Server Protocol LSP
	  lsp = {
		enable = true;
		servers = {
		  bashls.enable = true;
		  rust-analyzer.enable = true;
		  pylyzer.enable = true;
		  yamlls.enable = true;
		  lua-ls.enable = true;
		  nixd.enable = true;
		  helm-ls.enable = true;
		};
	  };

      bufferline.enable = true;
      lualine.enable = true;
      nix.enable = true;
      helm.enable = true;
      oil = {
        enable = true;
        settings = {
          cleanup_delay_ms = 1000;
          delete_to_trash = true;
          columns = [
            "type" "size" "permissions" "mtime" "icon" 
          ];
          skip_confirm_for_simple_edits = true;
          use_default_keymaps = false;
          keymaps = {
            "?" = "actions.show_help";
            "l" = "actions.select";
            "h" = "actions.parent";
            "hh" = "actions.toggle_hidden";
            "p" = "actions.preview";
            "r" = "actions.refresh";
            "q" = "actions.close";
          };
          view_options = {
            show_hidden = true;
            natural_order = true;
          };
        };
      };
      neogit.enable = true;
      notify = {
	    enable = true;
	    topDown = true;
      };
      nvim-autopairs.enable = true;
      which-key.enable = true;
      toggleterm = {
        enable = true;
        settings = {
          hide_numbers = true;
          autochdir = true;
          close_on_exit = true;
          direction = "vertical";
        };
      };
      noice.enable = true;
      alpha = {
	    enable = true;
        #theme = "dashboard";
        layout = [
   		{
          type = "padding";
          val = 20;
      	}
      	{
          opts = {
            hl = "Type";
            position = "center";
          };
          type = "text";
          val = [
            "  ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗  "
            "  ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║  "
            "  ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║  "
            "  ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║  "
            "  ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║  "
            "  ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝  "
          ];
        }
        {
          type = "padding";
          val = 4;
        }
        {
          opts = {
            hl = "Keyword";
            position = "center";
          };
          type = "text";
          val = "Nix is a way of life... Like DevOps only better !!!";
        }
        {
          type = "padding";
          val = 10;
        }
        {
          type = "group";
          opts = {
            hl = "Type";
            position = "center";
          };
          val = [{
            type = "button";
            on-press = "<cmd>Telescope find_files hidden=true<CR>";
            val = " Find Files...";
            opts = {
              shortcut = "SPACE + f f  ->  ";
              position = "center";
              padding = 4;
            };
          }
          {
            type = "button";
            on-press = "<cmd>Telescope live_grep hidden=true<CR>";
            val = " Live Grep...";
            opts = {
              shortcut = "SPACE + f g  ->  ";
              position = "center";
              padding = 4;
            };
          }
          {
            type = "button";
            on-press = "<cmd>Telescope file_browser<CR>";
            val = " File Browser...";
            opts = {
              shortcut = "SPACE + f b  ->  ";
              position = "center";
              padding = 4;
            };
          }
          {
            type = "button";
            on-press = "<cmd>Telescope projects<CR>";
            val = " Recent Projects...";
            opts = {
              shortcut = "SPACE + f p  ->  ";
              position = "center";
              padding = 4;
            };
          }
          {
            type = "button";
            val = " Quit NeoVim ...";
            opts = {
              shortcut = "SPACE q  ->  ";
              position = "center";
              padding = 4;
            };
          }];
        }];	
      };
      telescope = {
        enable = true;
        extensions = {
          fzf-native = {
            enable = true;
          };
          file-browser = {
            enable = true;
            settings = {
              gruped = true;
              hidden = {
                file_browser = true;
                folder_browser = true;
              };
              mappings.i = {
                "<C-c>" = "require('telescope._extensions.file_browser.actions').create";
			    "<S-CR>" = "require('telescope._extensions.file_browser.actions').create_from_prompt";
                "<A-r>" = "require('telescope._extensions.file_browser.actions').rename";
                "<A-m>" = "require('telescope._extensions.file_browser.actions').move";
                "<A-y>" = "require('telescope._extensions.file_browser.actions').copy";
                "<A-d>" = "require('telescope._extensions.file_browser.actions').remove";
                "<C-g>" = "require('telescope._extensions.file_browser.actions').goto_parent_dir";
                "<C-h>" = "require('telescope._extensions.file_browser.actions').goto_home_dir";
                "<C-w>" = "require('telescope._extensions.file_browser.actions').goto_cwd";
                "<C-t>" = "require('telescope._extensions.file_browser.actions').change_cwd";
                "<C-f>" = "require('telescope._extensions.file_browser.actions').toggle_browser";
                "<C-hh>" = "require('telescope._extensions.file_browser.actions').toggle_hidden";
                "<C-s>" = "require('telescope._extensions.file_browser.actions').toggle_all";
                "<bs>" = "require('telescope._extensions.file_browser.actions').backspace";
              };
              mappings.n = {
                "c" = "require('telescope._extensions.file_browser.actions').create";
                "r" = "require('telescope._extensions.file_browser.actions').rename";
                "m" = "require('telescope._extensions.file_browser.actions').move";
                "y" = "require('telescope._extensions.file_browser.actions').copy";
                "d" = "require('telescope._extensions.file_browser.actions').remove";
                "h" = "require('telescope._extensions.file_browser.actions').goto_parent_dir";
                "e" = "require('telescope._extensions.file_browser.actions').goto_home_dir";
                "w" = "require('telescope._extensions.file_browser.actions').goto_cwd";
                "t" = "require('telescope._extensions.file_browser.actions').change_cwd";
                "f" = "require('telescope._extensions.file_browser.actions').toggle_browser";
                "hh" = "require('telescope._extensions.file_browser.actions').toggle_hidden";
                "s" = "require('telescope._extensions.file_browser.actions').toggle_all";
              };
              defaults = {
                file_ignore_patterns = [
                  "^.git/"
                  "^.odt/"
                  "^.pdf/"
                  "^.local/"
                  "^.cargo/"
                  "^.cache/"
                  "^.steam/"
                  "^.rustup/"
                  "^.nix*"
                  "mySpace"
                  "venv/lib"
                  ".thunderbird/"
               ];
             };
           };
         };
       };
     };

     project-nvim = {
       enable = true;
       enableTelescope = true;
     };
     none-ls = {
       enable = true;
     };
     neo-tree = {
       enable = true;
     	enableDiagnostics = true;
     	enableGitStatus = true;
     	enableModifiedMarkers = true;
     	enableRefreshOnWrite = true;
     	closeIfLastWindow = true;
     	popupBorderStyle = "rounded"; # Type: null or one of “NC”, “double”, “none”, “rounded”, “shadow”, “single”, “solid” or raw lua code
     	buffers = {
         bindToCwd = false;
         followCurrentFile = {
           enabled = true;
         };
     	};
       window = {
         width = 40;
         height = 15;
         autoExpandWidth = false;
         mappings = {
           "<space>" = "none";
         };
       };
     };
   };

   # Keymaps
   globals.mapleader = " ";
   keymaps = [
     # Helpers
     {
       action = "<cmd>WhichKey<CR>";
       key = "<leader>ß";
     }

     # Maggit
     {
       mode = "n";
       action = "<cmd>Neogit<CR>";
       key = "<leader>g";
       options = {
         silent = true;
       };
     }

     #Dashboard
     {
       mode = "n";
       action = "<cmd>Alpha<CR>";
       key = "<leader>od";
       options = {
         silent = true;
       };
     }

     # Neotree
     {
       mode = "n";
       action = "<cmd>Neotree toggle<CR>";
       key = "<leader>tn";
       options = {
         silent = true;
       };
     }

     # Telescope find stuff
     {
       action = "<cmd>Telescope live_grep hidden=true<CR>";
       key = "<leader>fg";
     }
     {
       action = "<cmd>Telescope find_files hidden=true<CR>";
       key = "<leader>ff";
     }
     {
       action = "<cmd>Telescope buffers<CR>";
       key = "<leader>bi";
     }
     {
       action = "<cmd>Telescope file_browser<CR>";
       key = "<leader>fb";
     }
     {
       action = "<cmd>Telescope projects<CR>";
       key = "<leader>fp";
     }

     # Oil dired
     {
       action = "<cmd>Oil --float<CR>";
       key = "<leader>dd";
     }
     {
       action = "<cmd>Oil --float /home/ppuscasu/<CR>";
       key = "<leader>dh";
     }
     {
       action = "<cmd>Oil --float /home/ppuscasu/.config/nixos/<CR>";
       key = "<leader>dn";
     }
     {
       action = "<cmd>Oil --float /home/ppuscasu/.local/bin/<CR>";
       key = "<leader>db";
     }
     {
       action = "<cmd>Oil --float /home/ppuscasu/projects/<CR>";
       key = "<leader>dp";
     }
     {
       action = "<cmd>Oil --float /home/.config/<CR>";
       key = "<leader>dc";
     }

     # Buffers
     {
       action = "<cmd>BufferLineCycleNext<CR>";
       key = "<leader>bn";
     }
     {
       action = "<cmd>BufferLineCycleNext<CR>";
       key = "gt";
     }
     {
       action = "<cmd>BufferLineCyclePrev<CR>";
       key = "gT";
     }
     {
       action = "<cmd>BufferLineCyclePrev<CR>";
       key = "<leader>bp";
     }
     {
       action = "<cmd>BufferLinePickClose<CR>";
       key = "<leader>bk";
     }
     {
       action = "<cmd>BufferLinePick<CR>";
       key = "<leader>bs";
     }

     # Navigation cammands
     {
       action = "<cmd>:wincmd h<CR>";
       key = "<leader>wh";
     }
     {
       action = "<cmd>:wincmd j<CR>";
       key = "<leader>wj";
     }
     {
       action = "<cmd>:wincmd k<CR>";
       key = "<leader>wk";
     }
     {
       action = "<cmd>:wincmd l<CR>";
       key = "<leader>wl";
     }
     {
       action = "<cmd>:wincmd c<CR>";
       key = "<leader>wc";
     }
     {
       action = "<cmd>:wincmd v<CR>";
       key = "<leader>wv";
     }
     {
       action = "<cmd>:wincmd n<CR>";
       key = "<leader>wn";
     }
     {
       action = "<cmd>:wwincmd wq<CR>";
       key = "<leader>q";
     }
   ];
  };
}
