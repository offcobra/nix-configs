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
     {
       action = "<cmd>:checkhealth<CR>";
       key = "<leader>hh";
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

     # ToggleTerm Keys
     {
       mode = "n";
       action = "<cmd>ToggleTerm size=25 direction=horizontal name=term-vertical<CR>";
       key = "<leader>tv";
       options = {
         silent = true;
       };
     }
     {
       mode = "n";
       action = "<cmd>ToggleTerm size=120 direction=vertical name=term-horizontal<CR>";
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
       mode = "t";
       action = "<C-\\><C-n>";
       key = "<esc>";
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
       action = "<cmd>:wincmd wq<CR>";
       key = "<leader>q";
     }];
  };
}
