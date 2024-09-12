{ userSettings, ... }:

{
  # nvim Keybindings
  programs.nixvim = {

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
       key = "<leader>gg";
       options = {
         silent = true;
       };
     }
    {
      mode = "n";
      key = "<leader>gB";
      action = ":Gitsigns blame_line<CR>";
      options = {
        silent = true;
        desc = "Blame line";
      };
    }
    {
      mode = "n";
      key = "<leader>gr";
      action = ":Gitsigns reset_buffer<CR>";
      options = {
        silent = true;
        desc = "Reset Buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>gs";
      action = ":Gitsigns stage_buffer<CR>";
      options = {
        silent = true;
        desc = "Stage Buffer";
      };
    }

     # Dashboard
     {
       mode = "n";
       action = "<cmd>Alpha<CR>";
       key = "<leader>od";
       options = {
         silent = true;
       };
     }

     # LSP Keymaps
     {
       mode = "n";
       action = "<cmd>LspInfo<CR>";
       key = "<leader>li";
       options = {
         silent = true;
       };
     }
     {
       mode = "n";
       action = "<cmd>LspStop<CR>";
       key = "<leader>ls";
       options = {
         silent = true;
       };
     }
     {
       mode = "n";
       action = "<cmd>LspStart<CR>";
       key = "<leader>lS";
       options = {
         silent = true;
       };
     }
     {
       mode = "n";
       action = "<cmd>LspRestart<CR>";
       key = "<leader>lr";
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
     {
       mode = "n";
       action = "<cmd>ZenMode<CR>";
       key = "<leader>tz";
       options = {
         silent = true;
       };
     }
     {
       mode = "n";
       action = "<cmd>Markview<CR>";
       key = "<leader>tm";
       options = {
         silent = true;
       };
     }

     # ToggleTerm Keys
     {
       mode = "n";
       action = "<cmd>ToggleTerm size=15 direction=horizontal name=term-vertical<CR>";
       key = "<leader>tv";
       options = {
         silent = true;
       };
     }
     {
       mode = "n";
       action = "<cmd>ToggleTerm size=150 direction=vertical name=term-horizontal<CR>";
       key = "<leader>th";
       options = {
         silent = true;
       };
     }
     {
       mode = "n";
       action = "<cmd>ToggleTerm direction=float name=term-float<CR>";
       key = "<leader>tf";
       options = {
         silent = true;
       };
     }
     {
       mode = "n";
       action = "<cmd>ToggleTerm direction=tab name=term-tab<CR>";
       key = "<leader>tt";
       options = {
         silent = true;
       };
     }
     {
       mode = "t";
       action = "<C-\\><C-n>";
       key = "<esc><esc>";
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
     {
       action = "<cmd>Telescope git_branches<CR>";
       key = "<leader>gb";
     }
     {
       action = "<cmd>Telescope yank_history<CR>";
       key = "<leader>fv";
     }

     # Obsidian
     {
       action = "<cmd>ObsidianNew<CR>";
       key = "<leader>on";
     }
     {
       action = "<cmd>ObsidianSearch<CR>";
       key = "<leader>os";
     }
     {
       action = "<cmd>ObsidianLink<CR>";
       key = "<leader>oL";
     }
     {
       action = "<cmd>ObsidianLinks<CR>";
       key = "<leader>ol";
     }
     {
       action = "<cmd>ObsidianBacklinks<CR>";
       key = "<leader>ob";
     }
     {
       action = "<cmd>ObsidianTags<CR>";
       key = "<leader>ot";
     }
     {
       action = "<cmd>ObsidianRename<CR>";
       key = "<leader>or";
     }

     # Oil dired
     {
       action = "<cmd>Oil --float<CR>";
       key = "<leader>dd";
     }
     {
       action = "<cmd>Oil --float /home/${userSettings.username}/<CR>";
       key = "<leader>dh";
     }
     {
       action = "<cmd>Oil --float /home/${userSettings.username}/.config/nixos/<CR>";
       key = "<leader>dn";
     }
     {
       action = "<cmd>Oil --float /home/${userSettings.username}/.local/bin/<CR>";
       key = "<leader>db";
     }
     {
       action = "<cmd>Oil --float /home/${userSettings.username}/projects/<CR>";
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
       mode = "n";
       action = "<cmd>:wincmd h<CR>";
       key = "<leader>wh";
     }
     {
       mode = "n";
       action = "<cmd>:wincmd j<CR>";
       key = "<leader>wj";
     }
     {
       mode = "n";
       action = "<cmd>:wincmd k<CR>";
       key = "<leader>wk";
     }
     {
       mode = "n";
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

     # Todo work file
     {
       action = "<cmd>edit ~/obsidian/notes/work.md<CR>";
       key = "<leader>tw";
     }

     # Quit nvim
     {
       mode = "n";
       action = "<cmd>quit<CR>";
       key = "<leader>q";
     }];
  };
}
