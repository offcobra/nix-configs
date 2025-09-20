{ pkgs, ... }:

{
  # Ollama AI service
  nixpkgs.config.rocmSupport = true;
  services.ollama = {
    enable = true;
    package = pkgs.ollama;
    # 127.0.0.1:11434 -> Listening Address
    # for rocm info
    # nix-shell -p "rocmPackages.rocminfo" --run "rocminfo" | grep "gfx"
    acceleration = "rocm";
    rocmOverrideGfx = "10.3.0";
  };

}
