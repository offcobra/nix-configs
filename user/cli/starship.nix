{ lib, ... }:

{
  # Configure starship prompt
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      add_newline = true;
      format = lib.concatStrings [
        "$git_branch"
        "$git_state"
        "$git_status"
        #"$cmd_duration"
        "$line_break"
        "$python"
        "$rust"
        "$directory"
        "$character"
      ];
      os = {
        disabled = false;
        format = " ";
        style = "blue";
      };
      directory = {
        style = "blue";
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
          ".config" = " ";
          "nixos" = " ";
          "emacs" = " ";
        };
      };
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };
      git_branch = {
        format = "[ $branch]($style)";
        style = "bright-black";
      };

      git_status = {
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
        style = "cyan";
        conflicted = "​";
        untracked = "​";
        modified = " ​";
        staged = "​";
        renamed = "​";
        deleted = "​";
        stashed = "";
      };

      git_state = {
        format = "\([$state( $progress_current/$progress_total)]($style)\) ";
        style = "bright-black";
      };

      cmd_duration = {
        format = " [$duration]($style) ";
        style = "yellow";
      };

      python = {
        format = "[󰌠 $virtualenv]($style) ";
        style = "yellow";
      };

      docker_context = {
        symbol = " ";
        style = "yellow";
        #format = '[ $symbol ]($style)'
        detect_files = ["docker-compose.yaml" "docker-compose.yml" "Dockerfile"];
      };

      haskell = {
        symbol = " ";
        format = "[ $symbol ]($style)";
      };

      java = {
        symbol = " ";
        format = "[ $symbol ]($style)";
      };

      rust = {
        symbol = " ";
        style = "yellow";
        format = "[ $symbol ]($style)";
        detect_files = ["Cargo.toml"];
        detect_extensions = [".rs"];
      };
    };
  };
}
