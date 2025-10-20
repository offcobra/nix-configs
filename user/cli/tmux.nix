{ pkgs, ... }:

{
  # tmux Configs
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    historyLimit = 10000;
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
	      set -g @catppuccin_flavour 'mocha'
          set -g @catppuccin_window_status_style "rounded"

          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_window_number_position "right"

          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#W"

          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#W"

          set -g @catppuccin_status_modules_right "directory session"
          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator ""
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_connect_separator "no"

          set -g @catppuccin_directory_text "#{pane_current_path}"
        '';
	  }
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.vim-tmux-navigator
    ];
      #set -g default-terminal 'xterm-256color'
    extraConfig = "
      set-option -g prefix M-f

      set-option -g status-position top
      set -g status-style bg=terminal,fg=terminal

      set-window-option -g mode-keys vi

      set -s escape-time 0

      set-option -g default-terminal 'screen-256color'
      set-option -ga terminal-overrides ',xterm-256color:RGB'

      set -g mouse on

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R
    ";
  };
}
