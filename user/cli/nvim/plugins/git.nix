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

    # git blame tool
    gitsigns = {
      settings = {
        current_line_blame = true;
        trouble = true;
      };
    };
  };
}
