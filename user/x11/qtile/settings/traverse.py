""" Module to traverse across Screens """

from libqtile.command.client import InteractiveCommandClient
from libqtile.config import Screen
from libqtile.log_utils import logger

client = InteractiveCommandClient()

SPECIAL_GROUPS = ['treetab', 'max']

def up(qtile):
    if qtile.current_layout in SPECIAL_GROUPS:
        #qtile.current_group.prev_window()
        logger.logger('############## This hsit is working.....')
    else:
        pass
        #_focus_window(qtile, -1, 'y')


def down(qtile):
    if qtile.current_layout in SPECIAL_GROUPS:
        #qtile.current_group.next_window()
        logger.warning('############## This hsit is working.....')
    else:
        #_focus_window(qtile, 1, 'y')
        pass


def left(qtile):
    _focus_window(qtile, -1, 'x')


def right(qtile):
    _focus_window(qtile, 1, 'x')


def _focus_window(qtile, dir, axis):
    win = None
    win_wide = None
    dist = 10000
    dist_wide = 10000
    cur = qtile.current_window
    if not cur:
        cur = qtile.current_screen

    if axis == 'x':
        dim = 'width'
        band_axis = 'y'
        band_dim = 'height'
        cur_pos = cur.x
        band_min = cur.y
        band_max = cur.y + cur.height
    else:
        dim = 'height'
        band_axis = 'x'
        band_dim = 'width'
        band_min = cur.x
        cur_pos = cur.y
        band_max = cur.x + cur.width

    cur_pos += getattr(cur, dim) / 2

    windows = [w for g in qtile.groups if g.screen for w in g.windows]
    windows.extend([s for s in qtile.screens if not s.group.windows])

    if cur in windows:
        windows.remove(cur)

    for w in windows:
        if isinstance(w, Screen) or not w.minimized:
            pos = getattr(w, axis) + getattr(w, dim) / 2
            gap = dir * (pos - cur_pos)
            if gap > 5:
                band_pos = getattr(w, band_axis) + getattr(w, band_dim) / 2
                if band_min < band_pos < band_max:
                    if gap < dist:
                        dist = gap
                        win = w
                else:
                    if gap < dist_wide:
                        dist_wide = gap
                        win_wide = w

    if not win:
        win = win_wide
    if win:
        qtile.focus_screen(win.group.screen.index)
        win.group.focus(win, True)
        if not isinstance(win, Screen):
            win.focus(False)
