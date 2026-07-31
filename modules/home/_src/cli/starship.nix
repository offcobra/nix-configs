{ lib, ... }:

{
  # Configure starship prompt
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    settings = {
      add_newline = true;
      format = lib.concatStrings [
        "$kubernetes"
        "$line_break"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$os"
        "$cmd_duration"
        "$line_break"
        "$python"
        "$rust"
        "$directory"
        "$character"
      ];
      os = {
        disabled = false;
        format = "[#------------> $symbol <------------#]($style)";
        style = "bright-black";
        symbols = {
          "Alpine" = " Alpine";
          "Arch" = " Arch";
          "Artix" = " Artix";
          "Debian" = " Debian";
          "Ubuntu" = "󰕈 Ubuntu";
          "Kali" = " Kali";
          "Fedora" = " Fedora";
          "NixOS" = " NixOS";
          "RockyLinux" = " RockyLinux";
          "Unknown" = " Unknown";
        };
      };
      kubernetes = {
        disabled = false;
        symbol = "⎈";
        format = "[$symbol](blue) [Cluster:](bright-black) [$context]($style) [Namespace:](bright-black) [\($namespace\)]($style)";
        contexts = [{
          context_pattern = "^production$";
          context_alias = "production";
          style = "red";
        }{
          context_pattern = "^staging$";
          context_alias = "staging";
          style = "blue";
        }{
          context_pattern = "^test$";
          context_alias = "test";
          style = "green";
        }];
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
          "projects" = " ";
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
        format = "[[(*$conflicted$modified$staged)](218) ($ahead_behind$stashed)]($style)";
        style = "cyan";
        conflicted = "  ";
        modified = "  ";
        staged = "  ";
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
        format = "[ $symbol ]($style)";
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
