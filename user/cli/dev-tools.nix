{ pkgs, userSettings, ... }:

{
  # List of secondary Applications
  home.packages = with pkgs; [

    # Container tools
    kubectl
    #k9s
    helm
    podman

    # Network
    nmap
    rustscan
    dig
  ];

  # Bash Aliases for work
  programs.bash.shellAliases = {
    # Alacritty Config keybinding for wsl
    term-conf="vim /mnt/c/Users/${userSettings.username}/AppData/Roaming/Alacritty/alacritty.toml";
    glaze="vim /mnt/c/Users/${userSettings.username}/AppData/Roaming/Alacritty/glazewm.yaml";

    # Kubectl Aliases
    tk = "kubectl --kubeconfig ~/projects/devops/kubectl_config/test.yaml";
    sk = "kubectl --kubeconfig ~/projects/devops/kubectl_config/staging.yaml";
    pk = "kubectl --kubeconfig ~/projects/devops/kubectl_config/production.yaml";

    # Cleanup failed pods...
    k_clean_p_test = "tk delete pods --field-selector status.phase=Failed --all-namespaces";
    k_clean_p_staging = "sk delete pods --field-selector status.phase=Failed --all-namespaces";
    k_clean_p_production = "pk delete pods --field-selector status.phase=Failed --all-namespaces";

    # Cleanup failed pods..
    k_clean_j_test = "tk delete jobs --field-selector status.successful=0 --all-namespaces";
    k_clean_j_staging = "sk delete jobs --field-selector status.successful=0 --all-namespaces";
    k_clean_j_production = "pk delete jobs --field-selector status.successful=0 --all-namespaces";

    # CleanUp pods & jobs
    k_clean_test = "tk delete pods --field-selector status.phase=Failed --all-namespaces";
    k_clean_staging = "sk delete pods --field-selector status.phase=Failed --all-namespaces";
    k_clean_production = "pk delete pods --field-selector status.phase=Failed --all-namespaces";

    # k9s
    tk9 = "k9s --kubeconfig ~/projects/devops/kubectl_config/test.yaml -A";
    sk9 = "k9s --kubeconfig ~/projects/devops/kubectl_config/staging.yaml -A";
    pk9 = "k9s --kubeconfig ~/projects/devops/kubectl_config/production.yaml -A";
  };

  # K9s Config
  programs.k9s = {
    enable = true;
    settings = {
      k9s = {
        ui = {
          headless = true;
          enableMouse = false;
          crumbsless = true;
          logoless = true;
          noIcons = false;
          skin = "default";
        };
        readOnly = false;
        refreshRate = 2;
        maxConnRetry = 5;
        noExitOnCtrlC = true;
        skipLatestRevCheck = false;
        logger = {
          tail = 100;
          buffer = 5000;
          sinceSeconds = 60;
          fullScreenLogs = false;
          textWrap = false;
          showTime = false;
        };
        thresholds = {
          cpu = {
            critical = 90;
            warn = 70;
          };
          memory = {
            critical = 90;
            warn = 70;
          };
        };
      };
    };
    skins = {
      default = {
        k9s = {
          body = {
            bgColor = "default";
          };
          frame = {
            crumbs = {
              bgColor = "default";
            };
            title = {
              bgColor = "default";
            };
          };
          views = {
            table = {
              bgColor = "default";
              header = {
                bgColor = "default";
              };
            };
            xray = {
              bgColor = "default";
            };
            logs = {
              bgColor = "default";
              indicator = {
                bgColor = "default";
              };
            };
            charts = {
              bgColor = "default";
            };
          };
        };
      };
    };
  };
}
