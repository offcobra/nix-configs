{ pkgs, ... }:

let
  # Python Script Websearch
  websearch-nix = pkgs.writers.writePython3Bin "websearch.py" { } /*python*/''
    import os
    import subprocess

    # Define ENV Variables
    env_type = os.environ['XDG_SESSION_TYPE']
    BROWSER = "qutebrowser"
    if env_type == "wayland":
        DMENU = "fuzzel --dmenu"
    else:
        DMENU = "rofi --dmenu"

    WEBSEARCH = {
        # Search Engines
        "󰞉  brave": "https://search.brave.com/search?q=",
        "󰇥  duckduckgo": "https://duckduckgo.com/?q=",
        "  google": "https://www.google.com/search?q=",
        "󰆚  swisscows": "https://swisscows.com/web?query=",

        # News Engines
        "  bbcnews": "https://www.bbc.co.uk/search?q=",
        "  cnnnews": "https://www.cnn.com/search?q=",
        "  googlenews": "https://news.google.com/search?q=",
        "  wikipedia": "https://en.wikipedia.org/w/index.php?search=",
        "  wiktionary": "https://en.wiktionary.org/w/index.php?search=",

        # Social media
        "  reddit": "https://www.reddit.com/search/?q=",
        "󰭹  odysee": "https://odysee.com/$/search?q=",
        "  youtube": "https://www.youtube.com/results?search_query=",

        # Online Markets
        "  amazon": "https://www.amazon.de/s?k=",
        "  ebay": "https://www.ebay.de/sch/i.html?&_nkw=",
        "  idealo":
        "https://www.idealo.de/preisverleich/\
        MainSearchProductCateory.html?q=",

        # Linux / opensource Stuff
        "  archaur": "https://aur.archlinux.org/packages/?O:0&K=",
        "  archpkg": "https://archlinux.org/packages/?sort:&q=",
        "󰣇  archwiki": "https://wiki.archlinux.or/index.php?search=",
        "  debianpkg":
        "https://packages.debian.org/search?suite=default&\
        section=all&arch=any&searchon=names&keywords=",
        "  dockerhub": "https://hub.docker.com/search?q=",
        "  flathub": "https://flathub.org/apps/search?q=",
        "󱄅  nixos":
        "https://search.nixos.org/packages?channel=unstable&\
        from=0&size=50&sort=relevance&type=packages&query=",
        "󱄅  nixwiki": "https://nixos.wiki/index.php?search=",
        "󱄅  mynixos": "https://mynixos.com/search?q=",
        "  github": "https://github.com/search?q=",
        "  gitlab": "https://gitlab.com/search?search=",
        "  googleOpenSource": "https://opensource.google/projects/search?q=",
        "󰘬  sourceforge": "https://sourceforge.net/directory/?q=",
        "  stackoverflow": "https://stackoverflow.com/search?q=",
        "󱄅  nixvim":
        "https://nix-community.github.io/nixvim/user-guide/install.html?search=",
    }


    def run_fuzzel(elem, cmd=DMENU):
        """ Function to run fuzzel... """
        output = subprocess.check_output(
          f"echo '{elem}' | {cmd}", shell=True
          ).decode("utf-8").replace("\n", "")
        return output


    def main():
        """ Main Function """
        search = "\n".join(WEBSEARCH.keys())
        engine = run_fuzzel(search)
        query = run_fuzzel(engine)
        search_query = f"{WEBSEARCH[engine]}{query}"
        subprocess.run([BROWSER, search_query], check=True)


    if __name__ == '__main__':
        main()
    '';
in
{
  home.packages = [websearch-nix];
}
