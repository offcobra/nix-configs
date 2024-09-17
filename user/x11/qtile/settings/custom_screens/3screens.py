''' Module to define de Qtile Groups... '''

from libqtile import bar
from libqtile.lazy import lazy
from libqtile.config import Group, Key, Screen, DropDown, ScratchPad

from settings.widgets import init_widgets_list, init_widgets_secondary


mod = "mod4"

# TEST
# GROUPS
#--------
def_groups = []
group_keys = []

# FOR KEYBOARDS
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
group_labels = [" I", " II", "III", "IV", " V", "VI", "VII", "VIII", "IX", "X", "XI", "XII"]

group_layouts = [
    "monadtall","monadtall","monadtall","monadtall","monadtall",
    "monadtall","monadtall","monadtall","monadtall","monadtall",
    "monadtall","monadtall"
]

def go_to_group(group):
    ''' Function to focus group on default screen '''
    def f(qtile):
        if group in ['1', '4', '7', '10']:
            qtile.cmd_to_screen(0)
            qtile.groups_map[group].cmd_toscreen()
        elif group in ['2', '5', '8', '11']:
            qtile.cmd_to_screen(1)
            qtile.groups_map[group].cmd_toscreen()
        else:
            qtile.cmd_to_screen(2)
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
    if int(i.name) > 9:
        continue
    group_keys.extend([

#CHANGE WORKSPACES
        Key([mod], i.name, lazy.function(go_to_group(i.name))),
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
    ])

TERM = "kitty"

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
    #Key([], 'F1', lazy.function(go_to_group("10"))),
    #Key([], 'F2', lazy.function(go_to_group("11"))),
    #Key([], 'F3', lazy.function(go_to_group("12"))),
    Key([], 'F11', lazy.group["01"].dropdown_toggle('editor')),
    Key([], 'F10', lazy.group["00"].dropdown_toggle('term')),
    Key([], 'F12', lazy.group["02"].dropdown_toggle('s_monitor')),
])


def window_to_previous_group(qtile):
    ''' Window to previous Group '''
    if qtile.current_window is not None:
        #index = qtile.groups.index(qtile.current_group)
        index = int(qtile.current_group.name)
        if index in [1, 4, 7, 10]:
            qtile.current_window.togroup(qtile.groups[index + 1].name)
        else:
            qtile.current_window.togroup(qtile.groups[index - 2].name)

def window_to_next_group(qtile):
    ''' Window to previous Group '''
    if qtile.current_window is not None:
        #index = qtile.groups.index(qtile.current_group)
        index = int(qtile.current_group.name)
        if index in [3, 6, 9, 12]:
            qtile.current_window.togroup(qtile.groups[index - 3].name)
        else:
            qtile.current_window.togroup(qtile.groups[index].name)


def get_screens():
    ''' Create the Screens... '''
    screen_main = Screen(top=bar.Bar(widgets=init_widgets_list('full', 0), size=15, opacity=0.8, margin=[4,6,0,4]))
    screen_1 = Screen(top=bar.Bar(widgets=init_widgets_secondary('full', 1), size=15, opacity=0.8, margin=[4,6,0,4]))
    screen_2 = Screen(top=bar.Bar(widgets=init_widgets_secondary('full', 2), size=15, opacity=0.8, margin=[4,6,0,4]))
    return [screen_main, screen_1, screen_2]
