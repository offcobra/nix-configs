{ pkgs, ... }:

{
  # List of secondary Applications
  home.packages = with pkgs; [

    # Container tools
    kubectl
    helm
    podman

    # Network
    nmap
    rustscan
    dig
  ];
}
