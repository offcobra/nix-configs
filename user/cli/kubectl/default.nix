{ lib, pkgs, ... }:

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

    # K exec shell
    kshell = "k exec -ti";
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
    kubectl-neat
    kubectl-tree
    kubernetes-helm
    kubectl-explore
    # kubectl-graph

  ];

  # Download fubectl
  home.file.".local/bin/fubectl.source".source = builtins.fetchurl {
    url = "https://rawgit.com/kubermatic/fubectl/main/fubectl.source";
    sha256 = "sha256:1zbmj6rh2mf92c4vqgrln4h10iyqbynipdnkbys98pp8k7zsqpq0";
  };

  # Shell Aliases for kubectl
  programs.bash.shellAliases = kube-aliases;
  programs.fish.shellAliases = kube-aliases;
}
