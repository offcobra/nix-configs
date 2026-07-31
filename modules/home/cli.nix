# Aspect: cli -- the whole shell/terminal toolchain.
#
# The leaf configs live under _src (relocated from the old user/cli tree, kept
# out of import-tree by the leading underscore). shell.nix already imports the
# rest of the CLI stack (starship, tmux, tools, fzf, lf, zoxide, nvim, scripts,
# kubectl, macchina). nixvim's HM module is pulled in here because nvim needs it.
{ inputs, ... }:
{
  flake.modules.homeManager.cli = {
    imports = [
      inputs.nixvim.homeModules.nixvim
      ./_src/cli/shell.nix
      ./_src/cli/dev-tools.nix
    ];
  };
}
