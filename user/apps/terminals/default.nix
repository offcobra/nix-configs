{ ... }:

# Terminal are imported here...
{
  imports = [

    # Alacritty Config
    ./alacritty.nix

    # Kitty Config
    ./kitty.nix

    # Wezterm Config
    #./wezterm.nix

    # Ghostty Config
    ./ghostty.nix

  ];
}
