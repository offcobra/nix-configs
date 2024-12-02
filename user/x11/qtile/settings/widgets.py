''' Module to define the widgets for the bar.. '''

from libqtile import qtile
from libqtile import widget

from settings.colors import get_theme
from settings.helper import check_cpu # check_vpn, vpn_toggle,


myTerm = "alacritty"      # My terminal of choice
#myFont = "Source Code Pro"
myFont = "FiraCodeCerdFont"


customTerm = "alacritty --config-file /home/wally/.config/alacritty/alacritty_scratchpad.yml"

colors = get_theme()

# WIDGETS FOR THE BAR
#---------------------
#arch_symbols = '⮝⮝  ⋏ ◬ ⟑  ⩓'

# Separator with no with
def get_sep(width, pad=5, background=colors['background']):
    ''' get separator '''
    return widget.Sep(linewidth = width, padding = pad, foreground = colors['color1'], background = background)

# Display Python Image
py_image = widget.Image(
    #filename = "~/.config/qtile/icons/python-white.png",
    #filename = "~/.config/arco_icons/start-here-arcolinux-orange.svg",
    filename = "~/.config/arco_icons/debian3.png",
    scale = True,
    background = colors['background'],
    mouse_callbacks = {
        'Button1': lambda: qtile.cmd_spawn(
            customTerm + ' -t "Qtile Docs" --class qtile_docs --hold -e bat --pager "less" /home/wally/.config/docs/shortcuts.org'
    )})

# Groupbox for Display Groups
def get_group_box(visible_groups):
    ''' get group box '''
    groupbox = widget.GroupBox(
        font = myFont + ' Bold',
        visible_groups = visible_groups,
        fontsize = 9,
        margin_y = 4,
        margin_x = 0,
        padding_y = 5,
        padding_x = 5,
        borderwidth = 2,
        disable_drag = True,
        active = colors['active'],
        inactive = colors['inactive'],
        rounded = False,
        highlight_method = "line",
        this_current_screen_border = colors['color1'],
        foreground = colors['foreground'],
        background = colors['background']
    )
    return groupbox

# Current Layout
def get_current_layout():
    return widget.CurrentLayout(
        font = myFont + " Bold",
        fontsize = 9,
        foreground = colors['color1'],
        background = colors['background']
    )

# Current Layout
def get_current_icon_layout():
    return widget.CurrentLayoutIcon(
        current_icon_path = ["/home/wally/.config/qtile/icons"],
        font = myFont + " Bold",
        scale = 0.7,
        fontsize = 9,
        foreground = colors['color1'],
        background = colors['background']
    )

# Current Window
def get_window_name():
    ''' get current window name..'''
    return widget.WindowName(
        font = myFont + " Bold",
        format = '{name}',
        fontsize = 9,
        max_chars = 50,
        foreground = colors['active'],
        background = colors['background']
    )

# Text Box
def get_text_box(backc, forec, txt='', size=37, cmd=''):
    ''' Get textBox for wiget'''
    return widget.TextBox(
        text = txt,
        font = myFont + " Bold",
        background = backc,
        foreground = forec,
        padding = 0,
        fontsize = size,
        mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(cmd)}
    )

# Genn Pool Text
#vpn_widget = widget.GenPollText(
#    font = myFont + " Bold",
#    fontsize = 8,
#    update_interval=2,
#    func=lambda: check_vpn(),
#    foreground = colors['active'],
#    background = colors['background'],
#    mouse_callbacks = {
#        'Button1': lambda: qtile.cmd_spawn(myTerm + vpn_toggle()),
#        'Button3': lambda: qtile.cmd_spawn(myTerm + ' --hold -e watch nordvpn status'),
#    }
#)

cpu_widget = widget.GenPollText(
    font = myFont,
    fontsize = 10,
    update_interval=2,
    func=lambda: check_cpu(),
    foreground = colors['color1'],
    background = colors['background'],
    mouse_callbacks = {
        'Button1': lambda: qtile.cmd_spawn("bash /home/wally/.local/bin/toggle_cpu")
    }
)

# CPU Widget
cpu = widget.CPUGraph(
    fill_color = colors['color1'],
    graph_color = colors['color1'],
    background = colors['background'],
    border_width = 1,
    line_width = 1,
    core = "all",
    type = "box",
    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e bashtop')}
)

# Termal Sensor
thermal = widget.ThermalSensor(
    font = myFont + " Bold",
    foreground = colors['color4'],
    background = colors['background'],
    foreground_alert = colors['color2'],
    fontsize=9,
    bandwidth="down",
    metric = True,
    padding = 3,
    tag_sensor = "Tctl",
    threshold = 80,
    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + " --hold -t Sensors -e watch sensors")}
)

# NetGraph
net = widget.NetGraph(
    font = myFont + " Bold",
    fontsize=10,
    bandwidth="down",
    interface="auto",
    foreground = colors['foreground'],
    background = colors['background'],
    graph_color = colors['color2'],
    fill_color = colors['color2'],
    padding = 0,
    border_width = 1,
    line_width = 1,
    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' --hold -t TestInternetConn -e bash /home/wally/.local/bin/test-conn')}
)

# Memory
memory = widget.MemoryGraph(
    foreground = colors['foreground'],
    background = colors['background'],
    graph_color = colors['color3'],
    fill_color = colors['color3'],
    border_width = 1,
    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e bashtop')},
    frequency = 1
)

# Clock
def clock(backc):
    ''' retruns clock '''
    return widget.Clock(
        font = myFont + " Bold",
        foreground = colors['color1'],
        background = backc,
        fontsize = 11,
        format="%H:%M %d-%m-%Y ",
        mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' --hold -t Calender -e cal -y')}
    )

# SysTray
#systray = widget.StatusNotifier(
systray = widget.Systray(
    background = colors['background'],
    icon_size=16,
    padding = 7,
)

#battery = widget.Battery(
#    background = colors['background'],
#    foreground = colors['color4'],
#    fontsize=9,
#    font = myFont + " Bold",
#)

volume = widget.Volume(
    background = colors['background'],
    foreground = colors['color2'],
    fontsize=9,
    font = myFont + " Bold",
)

def init_widgets_list(screens='work', count=0):
    ''' Widgets for the main screen '''
    match screens:
        case 'full':
            groups = {
                '0': [1, 4, 7, 10],
                '1': [2, 5, 8, 11],
                '2': [3, 6, 9, 12]
            }
        case 'chill':
            groups = {
                '0': [1, 3, 5, 7, 9],
                '1': [2, 4, 6, 8, 10]
            }
        case 'work':
            groups = {
                '0': [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
            }

    widgets_list = [
        get_sep(0, 10),
        get_text_box(colors['background'], colors['inactive'], " ", 11),
        #py_image,
        get_sep(0, 5),
        get_group_box([str(x) for x in groups[str(count)]]),
        get_sep(0, 5),
        get_current_layout(),
        get_current_icon_layout(),
        get_window_name(),
        #vpn_widget,
        get_text_box(colors['background'], colors['color1'], " ", 10),
        volume,
        #get_text_box(colors['background'], colors['color1'], "   ", 10),
        #battery,
        widget.WidgetBox(
            background=colors['background'],
            font=myFont + " Bold",
            fontsize=11,
            text_open="⋟",
            text_closed="⋞",
            start_opened=False,
            widgets=[
                get_text_box(colors['background'], colors['foreground'], " ", 14),
                get_text_box(colors['background'], colors['color1'], " ", 10),
                cpu_widget,
                cpu,
                get_text_box(colors['background'], colors['foreground'], " ", 14),
                get_text_box(colors['background'], colors['color2'], " ", 10, cmd="websearch"),
                net,
                get_text_box(colors['background'], colors['foreground'], " ", 14),
                get_text_box(colors['background'], colors['color3'], " ", 11),
                memory,
                get_text_box(colors['background'], colors['foreground'], "", 14),
            ]
        ),
        #get_sep(0, 10, background=colors['background']),
        #clock(colors['background']),
        systray,
        get_sep(0, 10, background=colors['background']),
    ]

    if screens == 'work':
        widgets_list.append(
            clock(colors['background'])
        )

    return widgets_list


def init_widgets_secondary(screens, count):
    ''' widgets for the secundary Screen '''
    widgets = init_widgets_list(screens, count)[0:8].copy()
    widgets.extend([
        clock(colors['background'])
    ])
    return widgets
