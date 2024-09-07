{ ... }:

{
  programs.nixvim.plugins = {

    # File navigation / manager
    oil = {
      enable = true;
      settings = {
        #cleanup_delay_ms = 1000;
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
          "H" = "actions.toggle_hidden";
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
  };
}
