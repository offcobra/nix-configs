{ ... }:

{
  programs.nixvim.plugins = {

    # Treeview of current Project
    neo-tree = {
      enable = true;
        settings = {
    	  enable_diagnostics = true;
    	  enable_git_status = true;
    	  enable_modified_markers = true;
    	  enable_refresh_on_write = true;
    	  close_if_last_window = true;
    	  popup_border_style = "rounded"; # Type: null or one of “NC”, “double”, “none”, “rounded”, “shadow”, “single”, “solid” or raw lua code
          buffers = {
            bind_to_cwd = false;
            follow_current_file = {
              enabled = true;
            };
         };
         window = {
           width = 40;
           height = 15;
           autoExpandWidth = false;
         };
      };
    };
  };
}
