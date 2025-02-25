{ pkgs, userSettings, ... }:

let
  dev-aliases = {
    # Alacritty Config keybinding for wsl
    term-conf="vim /mnt/c/Users/${userSettings.username}/AppData/Roaming/Alacritty/alacritty.toml";
    glaze="vim /mnt/c/Users/${userSettings.username}/AppData/Roaming/Alacritty/glazewm.yaml";

    # Python env for testing
    pa = ". ~/projects/devops/nexgen/venv/bin/activate";
    pi = "source ~/projects/devops/nexgen_env.sh && pip install ~/projects/devops/nexgen/";
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

    # HashiCorp
    vault-bin
    boundary
    terraform

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

  # Dev Variables
  home.sessionVariables = {
     VAULT_ADDR = "http://10.222.48.30:8200";
     NIXPKGS_ALLOW_UNFREE = "1";
  };

  # Shell Aliases for work
  programs.bash.shellAliases = dev-aliases;
  programs.fish.shellAliases = dev-aliases;

}
