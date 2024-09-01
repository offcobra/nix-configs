{ config, ... }:

{
  # Rofi Config
  home.file = {
    "config.rasi" = {
      enable = true;
      target = ".config/rofi/config.rasi";
      text = ''
        configuration {
          modi: "window,drun,ssh,combi";
          font: "Fira Code 10";
          combi-modi: "window,drun,ssh";
        }
        @theme "./theme.rasi"
      '';
    };
    "theme.rasi" = {
      enable = true;
      target = ".config/rofi/theme.rasi";
      text = ''
        * {
            background-color:            #${config.colorScheme.palette.base00};
            border-color:                #${config.colorScheme.palette.base00};
            text-color:                  #${config.colorScheme.palette.base05};
            font:                        "Fira Code 9";
            prompt-font:                 @font;
            prompt-background:           #${config.colorScheme.palette.base08};
            prompt-foreground:           #${config.colorScheme.palette.base00};
            prompt-padding:              4px;
            alternate-normal-background: #${config.colorScheme.palette.base0D};
            alternate-normal-foreground: @background-color;
            selected-normal-background:  #${config.colorScheme.palette.base09};
            selected-normal-foreground:  #${config.colorScheme.palette.base00};
            spacing:                     3;
        }
        window {
            width:   380;
            border:  1;
            padding: 5;
        }
        #mainbox {
            border:  0;
            padding: 0;
        }
        #message {
            border:       1px dash 0px 0px ;
            padding:      1px ;
        }
        #listview {
            fixed-height: 0;
            border:       2px dash 0px 0px ;
            spacing:      2px ;
            scrollbar:    true;
            padding:      2px 0px 0px ;
            lines:        10;
        }
        #element {
            border:  0;
            padding: 1px ;
        }
        #element.selected.normal {
            background-color: @selected-normal-background;
            text-color:       @selected-normal-foreground;
        }
        #element.alternate.normal {
            background-color: @alternate-normal-background;
            text-color:       @alternate-normal-foreground;
        }
        #scrollbar {
            width:        0px ;
            border:       0;
            handle-width: 0px ;
            padding:      0;
        }
        #sidebar {
            border: 2px dash 0px 0px ;
        }
        #button.selected {
            background-color: @selected-normal-background;
            text-color:       @selected-normal-foreground;
        }
        #inputbar {
            spacing:    0;
            padding:    1px ;
        }
        #case-indicator {
            spacing:    0;
        }
        #entry {
            padding: 4px 4px;
            expand: false;
            width: 10em;
        }
        #prompt {
            padding:          @prompt-padding;
            background-color: @prompt-background;
            text-color:       @prompt-foreground;
            font:             @prompt-font;
            border-radius:    2px;
        }

        element-text {
            background-color: inherit;
            text-color:       inherit;
        }

        element-icon {
            background-color: inherit;
        }
      '';
    };
  };
}
