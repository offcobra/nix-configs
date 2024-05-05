{ config, pkgs, lib, ... }:

{
  # Configure Emacs
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [ 
      epkgs.vterm 
      epkgs.nerd-icons-dired
    ];
  };
}
