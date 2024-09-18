''' Module to define de Qtile Groups... '''

from libqtile import bar
from libqtile.lazy import lazy
from libqtile.config import Group, Key, Screen, DropDown, ScratchPad

from settings.widgets import init_widgets_list, init_widgets_secondary


mod = "mod4"

# GROUPS
#--------
def_groups = []
group_keys = []

# FOR KEYBOARDS
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0",]

#group_labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0",]
#group_labels = ["", "", "", "", "", "", "", "", "", "",]
group_labels = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X"]

group_layouts = [
    "monadtall","monadtall","monadtall","monadtall","monadtall",
    "monadtall","monadtall","monadtall","monadtall","monadtall"
]

def go_to_group(group):
    ''' Function to focus group on default screen '''
    def f(qtile):
        if group in '1234567890':
            qtile.cmd_to_screen(0)
            qtile.groups_map[group].cmd_toscreen()
        else:
            qtile.cmd_to_screen(0)
            qtile.groups_map[group].cmd_toscreen()

    return f

for i, value in enumerate(group_names):
    def_groups.append(
        Group(
            name=value,
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        ))

for i in def_groups:
    group_keys.extend([

#CHANGE WORKSPACES
        Key([mod], i.name, lazy.function(go_to_group(i.name))),
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
    ])

#TERM = "alacritty --config-file /home/wally/.config/alacritty/alacritty_scratchpad.yml"
TERM = "kitty"

def window_to_previous_group(qtile):
    ''' Window to previous Group '''
    pass

def window_to_next_group(qtile):
    ''' Window to previous Group '''
    pass

# Testing Scratchpads
def_groups.extend([
    ScratchPad("00", [
        DropDown("term", TERM, opacity=0.8)
    ]),
    ScratchPad("02", [
        DropDown("s_monitor", TERM + " -e btm", opacity=0.8)
    ]),
    ScratchPad("01", [
        DropDown("editor", TERM + " -e vim /home/wally/todo.txt", opacity=0.8)
    ])
])

group_keys.extend([
    Key([], 'F11', lazy.group["01"].dropdown_toggle('editor')),
    Key([], 'F10', lazy.group["00"].dropdown_toggle('term')),
    Key([], 'F12', lazy.group["02"].dropdown_toggle('s_monitor')),
])



def get_screens():
    ''' Create the Screens... '''
    return [Screen(top=bar.Bar(widgets=init_widgets_list('work', 0), size=15, opacity=1, margin=[4,6,0,6]))]
