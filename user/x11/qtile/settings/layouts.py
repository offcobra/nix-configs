''' Module to configure Qtile Layouts. '''

from libqtile import layout

from settings.colors import get_theme


color = get_theme()

# LAYOUTS
#--------
def init_layout_theme():
    ''' Set the default Themes for layout.. '''
    return {"margin": 6,
            "border_width": 1,
            "border_focus": "#E33D1A",
            "border_normal": "#4c566a",
            #"new_client_position": "top"
            "new_client_position": "before_current"
            }

layout_theme = init_layout_theme()

def_layouts = [
    layout.MonadTall(**layout_theme),
    #layout.MonadWide(**layout_theme),
    #layout.RatioTile(**layout_theme),
    layout.TreeTab(
         font = "Source Code Pro Bold",
         fontsize = 12,
         #sections = ["FIRST", "SECOND", "THIRD", "FOURTH"],
         sections = ["#=-> Stuff: <-=#"],
         section_fontsize = 14,
         border_width = 2,
         bg_color = "282c34",#"1c1f24",
         active_bg = "51afef",#"FF5733",
         active_fg = "000000",
         inactive_bg = "194d33",#"51afef",
         inactive_fg = "1c1f24",
         #bg_color = color["background"],
         #active_bg = color["active"],
         #active_fg = color["foreground"],
         #inactive_bg = color["inactive"],
         #inactive_fg = color["background"],
         padding_left = 0,
         padding_x = 0,
         padding_y = 5,
         section_top = 10,
         section_fg = "dfdfdf",
         section_bottom = 20,
         level_shift = 8,
         vspace = 3,
         panel_width = 135
         ),
    layout.Max(**layout_theme)
]
