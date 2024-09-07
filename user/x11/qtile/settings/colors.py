''' Colors Module.. '''
import json


THEME = "/home/wally/.config/theme.json"

# Default Colors
colors = {
    "background": ["#282c34", "#282c34"],
    "foreground": ["#51afef", "#51afef"],
    "active": ["#a9a1e1", "#a9a1e1"],
    "inactive": ["#da8548", "#da8548"],
    "color1": ["#dfdfdf", "#dfdfdf"],
    "color2": ["#ff6c6b", "#ff6c6b"],
    "color3": ["#c678dd", "#c678dd"],
    "color4": ["#98be65", "#98be65"],
    "color5": ["#46d9ff", "#46d9ff"],
    "barg": ['#194d33', '#194d33'],
    "barr": ['#993333', '#993333']
}

# Testing new color Theme system
def get_theme():
    ''' Function to get Theme '''
    with open(THEME, 'r') as f:
        try:
            print('Getting new color style')
            theme = json.loads(f.read())
        except Exception as exc:
            print('Getting old color style')
            theme = colors
    return theme
