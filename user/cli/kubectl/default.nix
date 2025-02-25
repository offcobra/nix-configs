{ pkgs, ... }:

let
  kube-aliases = {
    # Kubectl Aliases
    k9 = "k9s";
    k = "kubecolor";
    kc = "kubectx";
    kn = "kubens";
    ks = "kc && kn";

    # Debugging
    debug_pod = "k run -i --tty --rm debug --image=ubuntu:latest --restart=Never -n default -- /bin/bash";

    # Cleanup failed pods...
    clean_pods = "k delete pods --field-selector status.phase=Failed --all-namespaces";

    # Cleanup failed pods..
    clean_jobs = "k delete jobs --field-selector status.successful=0 --all-namespaces";

    # CleanUp pods & jobs
    k_clean = "clean_pods && clean_jobs";

    # Kubectl Explain Stuff
    kh = "k explore";

    # K Logs
    kl = "kubetail";
  };
in
{
  imports = [
    # htop for kube
    ./k9s.nix
    # Kubecolor
    ./kubecolor.nix
  ];

  # Kube Packages
  home.packages = with pkgs; [
    k3d
    kubetail
    kubectl
    kubectx
    kubecolor
    kubernetes-helm
    kubectl-explore
    # kubectl-graph

  ];

  # Shell Aliases for kubectl
  programs.bash.shellAliases = kube-aliases;
  programs.fish.shellAliases = kube-aliases;
}
