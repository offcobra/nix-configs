{ ... }:

{
  programs.nixvim.plugins = {

    # Quick search / fzf Tool
    telescope = {
      enable = true;
      settings = {
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
            "^venv/"
            "^.thunderbird/"
            "^.kube/"
          ];
        };
      };
      extensions = {
        fzf-native = {
          enable = true;
        };
        file-browser = {
          enable = true;
          settings = {
            grouped = true;
            hide_parent_dir = true;
            hidden = {
              file_browser = true;
              folder_browser = true;
            };
            mappings.i = {
              "<C-c>" = "require('telescope._extensions.file_browser.actions').create";
	  	    "<C-C>" = "require('telescope._extensions.file_browser.actions').create_from_prompt";
              "<C-r>" = "require('telescope._extensions.file_browser.actions').rename";
              "<C-m>" = "require('telescope._extensions.file_browser.actions').move";
              "<C-y>" = "require('telescope._extensions.file_browser.actions').copy";
              "<C-d>" = "require('telescope._extensions.file_browser.actions').remove";
              "<C-l>" = "require('telescope.actions').select_default";
              "<C-h>" = "require('telescope._extensions.file_browser.actions').goto_parent_dir";
              "<C-o>" = "require('telescope._extensions.file_browser.actions').open";
              "<C-g>" = "require('telescope._extensions.file_browser.actions').goto_home_dir";
              "<C-w>" = "require('telescope._extensions.file_browser.actions').goto_cwd";
              "<C-t>" = "require('telescope._extensions.file_browser.actions').change_cwd";
              "<C-f>" = "require('telescope._extensions.file_browser.actions').toggle_browser";
              "<C-H>" = "require('telescope._extensions.file_browser.actions').toggle_hidden";
              "<C-s>" = "require('telescope._extensions.file_browser.actions').toggle_all";
              "<bs>" = "require('telescope._extensions.file_browser.actions').backspace";
            };
            mappings.n = {
	  	    "C" = "require('telescope._extensions.file_browser.actions').create_from_prompt";
	  	    "c" = "require('telescope._extensions.file_browser.actions').create";
              "r" = "require('telescope._extensions.file_browser.actions').rename";
              "m" = "require('telescope._extensions.file_browser.actions').move";
              "y" = "require('telescope._extensions.file_browser.actions').copy";
              "d" = "require('telescope._extensions.file_browser.actions').remove";
              "l" = "require('telescope.actions').select_default";
              "h" = "require('telescope._extensions.file_browser.actions').goto_parent_dir";
              "o" = "require('telescope._extensions.file_browser.actions').open";
              "g" = "require('telescope._extensions.file_browser.actions').goto_home_dir";
              "w" = "require('telescope._extensions.file_browser.actions').goto_cwd";
              "t" = "require('telescope._extensions.file_browser.actions').change_cwd";
              "f" = "require('telescope._extensions.file_browser.actions').toggle_browser";
              "H" = "require('telescope._extensions.file_browser.actions').toggle_hidden";
              "s" = "require('telescope._extensions.file_browser.actions').toggle_all";
            };
          };
        };
      };
    };
  };
}
