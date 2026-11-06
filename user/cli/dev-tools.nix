{ pkgs, userSettings, ... }:

let
  dev-aliases = {
    # Alacritty Config keybinding for wsl
    term-conf="vim /mnt/c/Users/${userSettings.username}/AppData/Roaming/Alacritty/alacritty.toml";
    glaze="vim /mnt/c/Users/${userSettings.username}/AppData/Roaming/Alacritty/glazewm.yaml";

    # Python env for testing
    pa = ". ~/projects/devops/cli-nexgen/venv/bin/activate";
    pi = "source ~/projects/devops/nexgen_env.sh && pip install ~/projects/devops/cli-nexgen/";
    pai = "pa && pi";

    # Start AI service
    start-ai="sudo systemctl start ollama";
  };
in
{
  # List of secondary Applications
  home.packages = with pkgs; [
    # SNMP
    #net-snmp
    sslscan

    # AI Agent
    claude-code

    # HashiCorp
    vault-bin
    boundary
    terraform
    terragrunt

    # vsphere cli
    govc

    # stackit
    stackit-cli
    awscli

    # DevSecOps
    trivy
    buildah

    # Start Docker
    (pkgs.writeShellScriptBin "start-docker" /*bash*/ ''
       echo "#=> Starting docker..."
       sudo systemctl start docker

       echo "#=> Fixing mount Points..."
       sudo mount --make-shared /tmp/
       sudo mount --make-shared /

       echo "#=> Reloading SystemD..."
       sudo systemctl daemon-reload
    '')
  ];

  services.podman = {
    enable = true;
  };

  # Dev Variables
  home.sessionVariables = {
     VAULT_ADDR = "https://vault.fcbayern.cloud";
     NIXPKGS_ALLOW_UNFREE = "1";
  };

  # Shell Aliases for work
  programs.bash.shellAliases = dev-aliases;
  programs.fish.shellAliases = dev-aliases;

}
