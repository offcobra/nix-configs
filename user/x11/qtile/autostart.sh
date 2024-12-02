#!/bin/bash

##### ===-->> Qtile autostart Config <<--=== ######
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

# Starting utility applications at boot time
# For X11

#echo "Setting Screen resolution...."
#bash /home/wally/.local/bin/screen_full &

echo "Fix for GTK Apps starting slow..."
/usr/lib/xdg-desktop-portal-gnome &
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY &

echo "Setting Wallpapers"
nitrogen --restore &

echo "Starting Flameshot Screenshot tool"
flameshot &

echo "Starting Tray applets..."
nm-applet &
blueberry-tray &

echo "Start emacs daemon..."
emacs --daemon &

#echo "Starting Apps Conatiner..."
#xhost +local:*
#
#echo "Start signal in tray"
#flatpak run org.signal.Signal --start-in-tray &
#flatpak run com.rtosta.zapzap --start-hidden &

# Setting custom resolution
#xrandr --newmode "1280x960_165.00"  310.25  1280 1392 1528 1776  960 963 967 1060 -hsync +vsync
#xrandr --addmode DisplayPort-1 1280x960_165.00

notify-send -t 3000 "Qtile AutoStart" "All Autostart Apps Loaded..."
