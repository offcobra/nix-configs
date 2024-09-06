{ ... }:

{
  programs.nixvim.plugins = {

    # git client
    neogit = {
      enable = true;
      settings = {
        kind = "replace";
        commit_editor = {
          kind = "auto";
        };
        disable_commit_confirmation = true;
        diffview = true;
      };
    };

    # git diff view
    diffview.enable = true;

    # fugitive
    fugitive.enable = true;

    # git blame tool
    gitsigns = {
      enable = true;
      settings = {
        current_line_blame = true;
        trouble = true;
        signs = {
          add = {
            text = "│";
          };
          change = {
            text = "│";
          };
          delete = {
            text = "_";
          };
          topdelete = {
            text = "‾";
          };
          changedelete = {
            text = "~";
          };
          untracked = {
            text = "│";
          };
        };
      };
    };
  };
}
