{ ... }:

{
  programs.nixvim.plugins = {

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
        val = 2;
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
        val = 8;
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
  };
}
