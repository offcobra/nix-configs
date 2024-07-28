{ ... }:

{
  programs.nixvim.plugins = {

    # Quick search / fzf Tool
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
  };
}
