########## ===-->> Qtile Config <<--=== ###########
#------------------
# This is a config of:
#  ___   __  __ _____ _        __        __    _ _
# / _ \ / _|/ _|_   _| |__   __\ \      / /_ _| | |
#| | | | |_| |_  | | | '_ \ / _ \ \ /\ / / _` | | |
#| |_| |  _|  _| | | | | | |  __/\ V  V / (_| | | |
# \___/|_| |_|   |_| |_| |_|\___| \_/\_/ \__,_|_|_|
#
#
# Github Url: https://github.com/offcobra/dotfiles
# Github Ssh: git@github.com:offcobra/dotfiles.git
#--------------------------------------------------

import os
import subprocess

from libqtile import qtile
from libqtile import layout, hook
from libqtile.config import Match

from settings.keybindings import keybindings, mouse_keys
from settings.screens import def_groups, get_screens
from settings.layouts import def_layouts
#from settings.docs import set_docs

# run Kewybindings Documentation
#set_docs()

home = os.path.expanduser('~')

# KeyBindings
keys = keybindings

# MouseKeys
mouse = mouse_keys

# Groups
groups = def_groups

# layouts
layouts = def_layouts

# Screens Definition
screens = get_screens()


dgroups_key_binder = None
dgroups_app_rules = []


main = None

wl_input_rules = None

#from libqtile.backend.wayland import InputConfig
#wl_input_rules = {
#    "5426:599:Razer Razer Huntsman Mini": InputConfig(kb_layout='de'),
#    "4152:6224:SteelSeries SteelSeries Aerox 5": InputConfig(accel_profile='flat'),
#    "*": InputConfig(left_handed=True, pointer_accel=True),
#}


@hook.subscribe.startup_once
def start_once():
    ''' Start once '''
    if qtile.core.name == "x11":
        # TODO fix qtile-startup (x11 & wayland) & rm austostar.sh
        # subprocess.call(['bash', home + '/.config/qtile/autostart.sh'])
        subprocess.call(['qtile-startup'])
    else:
        # TODO remove unneeded script
        # print('Start Wayland stuff...')
        subprocess.call([home + '/.config/qtile/qautostart.sh'])


@hook.subscribe.startup
def start_always():
    ''' Start always '''
    # Set the cursor to something sane in X
    if qtile.core.name == "x11":
        subprocess.Popen(['xsetroot', '-cursor_name', 'left_ptr'])

@hook.subscribe.client_new
def set_floating(window):
    ''' set floating '''
    if (window.window.get_wm_transient_for()
            or window.window.get_wm_type() in floating_types):
        window.floating = True

floating_types = ["notification", "toolbar", "splash", "dialog"]

follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
    Match(wm_class='confirm'),
    Match(wm_class='dialog'),
    Match(wm_class='download'),
    Match(wm_class='error'),
    Match(wm_class='file_progress'),
    Match(wm_class='notification'),
    Match(wm_class='splash'),
    Match(wm_class='toolbar'),
    Match(wm_class='Arandr'),
    Match(wm_class='feh'),
    Match(wm_class='qtile_docs'),
    Match(wm_class='Galculator'),
    Match(wm_class='cs2'),
    Match(wm_class='steam_app_730'),
    Match(wm_class='steamwebhelper'),
    Match(wm_class='Counter-Strike 2'),
    Match(wm_class='archlinux-logout.py'),
    Match(wm_class='conky'),
    Match(wm_class='Blueberry.py'),
    Match(wm_class='com.rtosta.zapzap'),
    Match(wm_class='Signal'),
    Match(wm_class='ollama'),
    Match(wm_class='pavucontrol'),
],  fullscreen_border_width = 0, border_width = 0)
auto_fullscreen = True
auto_minimize = False

focus_on_window_activation = "smart" # or smart

wmname = "LG3D"
