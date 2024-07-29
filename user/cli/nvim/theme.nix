{ ... }:

{
  # Theme
  programs.nixvim.colorschemes.catppuccin = {
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
}
