''' Module to host keybindings '''
from libqtile.lazy import lazy
from libqtile.config import Drag, Key, KeyChord

# Custom plugin
from settings import traverse

from settings.screens import (
    group_keys,
    window_to_next_group,
    window_to_previous_group
)


#mod4 or mod = super key
mod = "mod4"
mod1 = "alt"


mod2 = "control"
#myTerm = "alacritty"      # My terminal of choice
myTerm = "foot"      # My terminal of choice


# Mouse keybindings
# -----------------
mouse_keys = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size())
]

# Keybindings
#------------
keybindings = [

# BASIC KEYBINDINGS
# Def my own Keybinding

    Key([mod], "Return", lazy.spawn("kitty -e fish"), desc="Kitty with bash shell"),
    Key(["control"], "Return", lazy.spawn("alacritty"), desc="Kitty Term with bash"),

    Key([mod], "p", lazy.spawn("rofi -show run"), desc="Programm Launcher"),
    Key([mod, "shift"], "p", lazy.spawn("websearch.py"), desc="Websearch Script"),
    Key([mod], "o", lazy.spawn("kitty --class ollama --title Ollama -e ollama run llama3.1"), desc="Ollama AI"),

    Key(["control"], "p", lazy.spawn("copyq show"), desc="Toggle Qtile Bar"),

    Key([mod, "shift"], "b", lazy.hide_show_bar("top"), desc="Toggle Qtile Bar"),

    Key([mod], "f", lazy.spawn("pcmanfm"), desc="File Manager"),
    Key([mod], "s", lazy.spawn("kitty -e btm"), desc="Fancy System Monitor"),
    Key([mod], "z", lazy.spawn("archlinux-logout"), desc="Logout / Restart / Shutdown"),
    Key([mod], "w", lazy.widget["widgetbox"].toggle(), desc="Toggle the WidgetBox"),
    Key([mod], "x", lazy.spawn('flameshot gui'), desc="Start screen snipped"),

# SUPER + FUNCTION KEYS
    Key([mod, "shift"], "n", lazy.layout.normalize(), desc="Normalize Layout"),
    Key([mod, "shift"], "f", lazy.window.toggle_floating(), desc="Toggle Floating"),
    Key([mod, "control"], "f", lazy.window.toggle_fullscreen(), desc="Toggle Floating"),
    Key([mod], "q", lazy.window.kill(), desc="Window Kill"),


# SUPER + SHIFT KEYS
    Key([mod, "shift"], "q", lazy.spawn("kill-qtile.sh")),
    Key([mod, "shift"], "r", lazy.restart(), desc="Restart Qtile"),


# QTILE LAYOUT KEYS
    Key([mod], "space", lazy.next_layout(), desc="Next Layout"),

# CHANGE FOCUS
    Key([mod], "k", lazy.layout.up(), desc="Move Up"),
    Key([mod], "j", lazy.layout.down(), desc="Move Down"),
    #Key([mod], "h", lazy.layout.left()),
    #Key([mod], "l", lazy.layout.right()),
    #Key([mod], "m", lazy.function(to_next)),
    #Key([mod], "n", lazy.function(to_prev)),
    #
# Traverse Plugin
    #Key([mod], 'k', lazy.function(traverse.up)),
    #Key([mod], 'j', lazy.function(traverse.down)),
    Key([mod], 'h', lazy.function(traverse.left), desc="Move Left"),
    Key([mod], 'l', lazy.function(traverse.right), desc="Move Right"),


# RESIZE UP, DOWN, LEFT, RIGHT
    Key([mod, "mod1"], "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        ),
    Key([mod, "mod1"], "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        ),
    Key([mod, "mod1"], "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        ),
    Key([mod, "mod1"], "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        ),

    # MOVE WINDOWS left / right & up / down
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # MOVE WINDOW TO NEXT SCREEN
    #Key([mod,"shift"], "l", lazy.function(window_to_next_group)),
    #Key([mod,"shift"], "h", lazy.function(window_to_previous_group)),


    Key([], "xf86audioraisevolume", lazy.spawn('amixer sset Master 5%+'), desc="Raise Volume..."),
    Key([], "xf86audiolowervolume", lazy.spawn('amixer sset Master 5%-'), desc="Lower Volume..."),
    Key([], "xf86audiomute", lazy.spawn('amixer sset Master 0'), desc="Lower Volume..."),

    Key([], "xf86MonBrightnessDown", lazy.spawn('light -U 5'), desc="Lower Light..."),
    Key([], "xf86MonBrightnessUp", lazy.spawn('light -A 5'), desc="Raise Light..."),

    Key([], "xf86Messenger", lazy.spawn('show-info.sh'), desc="Show Battery Info..."),

# KEYCHORD BINDINGS
# Basic Commands
    KeyChord([mod],"g", [
        Key([], "w",
            lazy.spawn("nitrogen"),
            desc='Nitrogen'
            ),
        Key([], "g",
            lazy.spawn("steam"),
            desc='Steam'
            ),
        Key([], "k",
            lazy.spawn("bitwarden"),
            desc='Bitwarden'
            ),
        Key([], "e",
            lazy.spawn("thunderbird"),
            desc='Thunderbird'
            ),
        Key([], "o",
            lazy.spawn("libreoffice"),
            desc='Libreoffice Desktop'
            ),
        Key([], "f",
            lazy.spawn("flatpak run com.github.tchx84.Flatseal"),
            desc='Flatpak Flatseal'
            ),
        Key([], "b",
            lazy.spawn("blueberry"),
            desc='Blueberry Desktop'
            ),
        Key([], "v",
            lazy.spawn("pavucontrol"),
            desc='Pavucontrol Desktop'
            ),
        Key([], "s",
            lazy.spawn("spotify"),
            desc='Spotify Desktop'
            ),
        Key([], "y",
            lazy.spawn("freetube"),
            desc='Youtube Client'
            )
    ], name="Common Programms"),

# Emacs
    KeyChord([mod],"e", [
        Key([], "n",
            lazy.spawn("kitty -T NeoVim -e nvim"),
            desc='Nvim Dashboard'
            ),
        Key([], "e",
            lazy.spawn("emacsclient -c -a 'emacs'"),
            desc='Emacsclient Dashboard'
            ),
        Key([], "b",
            lazy.spawn("emacsclient -c -a 'emacs' --eval '(ibuffer)'"),
            desc='Emacsclient Ibuffer'
            ),
        Key([], "r",
            lazy.spawn("emacsclient -c -a 'emacs' --eval '(doom/reload)'"),
            desc='Emacsclient Ibuffer'
            ),
        Key([], "d",
            lazy.spawn("emacsclient -c -a 'emacs' --eval '(dired nil)'"),
            desc='Emacsclient Dired'
            ),
        Key([], "t",
            lazy.spawn("emacsclient -c -a 'emacs' --eval '(+vterm/here nil)'"),
            desc='Emacsclient Vterm'
            )
    ], name="Emacs"),

# Browser
    KeyChord([mod],"b", [
        Key([], "b",
            lazy.spawn("brave"),
            desc='Brave'
            ),
        Key([], "i",
            lazy.spawn("brave --incognito"),
            desc='Brave Incognito'
            ),
        Key([], "t",
            lazy.spawn("docker_exec thorium-browser"),
            desc='Thorium'
            ),
        Key([], "h",
            lazy.spawn("docker_exec thorium-browser --incognito"),
            desc='Thorium Incognito'
            ),
        Key([], "o",
            lazy.spawn("qutebrowser"),
            desc='QuteBrowser'
            ),
        Key([], "z",
            lazy.spawn("flatpak run io.github.zen_browser.zen"),
            desc='Zen-Browser'
            ),
    ], name="Browsers"),

# Monitor Resolution / Picom toggle
    KeyChord([mod],"t", [
        Key([], "f",
            lazy.spawn("screen-full.sh"),
            desc='Monitors in full mode'
            ),
        Key([], "c",
            lazy.spawn("screen-chill.sh"),
            desc='Monitors in chill mode'
            ),
        Key([], "w",
            lazy.spawn("screen-work.sh"),
            desc='Monitors in work mode'
            ),
        Key([], "v",
            lazy.spawn("bash /home/wally/.config/bin/toggle_vpn"),
            desc='Toggle NordVPN'
            ),
    ], name="Toggle Scripts"),

# Crypto Stuff
    KeyChord([mod],"c", [
        Key([], "b",
            lazy.spawn("qutebrowser https://binance.com"),
            desc='Binance.com'
            ),
        Key([], "c",
            lazy.spawn("qutebrowser https://coinmarketcap.com/"),
            desc='Coinmarketcap'
            ),
        Key([], "p",
            lazy.spawn("qutebrowser https://mail.proton.me/"),
            desc='Proton Mail'
            ),
        Key([], "e",
            lazy.spawn("exodus"),
            desc='Exodus Wallet'
            ),
    ], name="Toggle Scripts"),

# Virtualization
    KeyChord([mod],"v", [
        Key([], "a",
            lazy.spawn("container_run apps"),
            desc='Spawns Ubuntu Container'
            ),
        Key([], "u",
            lazy.spawn("container_run ubuntu"),
            desc='Spawns Ubuntu Container'
            ),
        Key([], "d",
            lazy.spawn("container_run debian"),
            desc='Spawns Debian Container'
            ),
        Key([], "o",
            lazy.spawn("container_run opensuse"),
            desc='Spawns opensuse Container'
            ),
        Key([], "p",
            lazy.spawn("container_run parrot"),
            desc='Spawns ParrotOs Container'
            ),
        Key([], "f",
            lazy.spawn("container_run fedora"),
            desc='Spawns Fedora Container'
            ),
        Key([], "k",
            lazy.spawn("container_run"),
            desc='Spawn and attach to Docker Container'
            ),
        Key([], "s",
            lazy.spawn("stop_docker"),
            desc='Remove all docker Container'
            ),
    ], name="Virtualization"),

# Chat Programms
    KeyChord([mod],"i", [
        Key([], "s",
            lazy.spawn("flatpak run org.signal.Signal"),
            desc='Signal'
            ),
        Key([], "d",
            lazy.spawn("flatpak run com.discordapp.Discord"),
            desc='Discord'
            ),
        Key([], "w",
            lazy.spawn("flatpak run io.github.mimbrero.WhatsAppDesktop"),
            desc='Whatsapp'
            ),
    ], name="Chating"),

]
keybindings.extend(group_keys)
