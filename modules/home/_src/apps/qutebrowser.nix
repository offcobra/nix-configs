{ config, userSettings, ... }:

{
  # Qutebrowser Configurations
  programs.qutebrowser = {
    enable = true;
    aliases = {
      "q" = "quit";
      "w" = "session-save";
    };
    searchEngines = {
      "DEFAULT" = "https://search.brave.com/search?q={}";
      "dd" = "https://duckduckgo.com/?q={}";
      "am" = "https://www.amazon.de/s?k={}";
      "gg" = "https://www.google.com/search?q={}";
      "re" = "https://www.reddit.com/r/{}";
    };
    settings = {
      colors = {
        hints = {
          bg = "#${config.colorScheme.palette.base00}";
          fg = "#${config.colorScheme.palette.base05}";
        };
        webpage.darkmode.enabled = true;
      };
      fonts = {
        default_family = "${userSettings.font}";
        default_size = "11px";
      };
      downloads.location.directory = "~/Downloads/";
      url = {
        default_page = "https://search.brave.com";
        start_pages = "https://search.brave.com";
      };
      statusbar.show = "never";
      tabs.show = "never";
    };
    extraConfig = "
config.set('content.cookies.accept', 'never', 'chrome-devtools://*')
config.set('content.cookies.accept', 'never', 'devtools://*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://accounts.google.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')
config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')
config.set('content.notifications.enabled', True, 'https://www.reddit.com')
config.set('content.notifications.enabled', True, 'https://www.youtube.com')
    ";
  };
}
