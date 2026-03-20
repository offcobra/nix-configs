{ pkgs, ... }:

{
  # Ollama AI service
  #nixpkgs.config.rocmSupport = true;
  services.ollama = {
    enable = true;
    # 127.0.0.1:11434 -> Listening Address
    # for rocm info
    # nix-shell -p "rocmPackages.rocminfo" --run "rocminfo" | grep "gfx"
    #port = 11434;
    #openFirewall = true;
    #package = pkgs.ollama-rocm;
    #package = pkgs.ollama-rocm;
  };

}
