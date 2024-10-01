#!/usr/bin/env bash

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

#Some ways to set your wallpaper besides variety or nitrogen
#wallpaper for other Arch based systems
#run variety -> To cycle wallpapers

#starting utility applications at boot time
# For Wayland

echo "Auth Agent & Notifyd"
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
#/usr/lib/xfce4/notifyd/xfce4-notifyd &
dunst &

echo "Setting Screen resolution...."
#bash /home/wally/.local/bin/screen_full &

echo "Start emacs daemon..."
#emacs --daemon &

echo "Setting Wallpapers"
hyprpaper &

#echo "Start XDG for Wayland..."
#/usr/lib/xdg-desktop-portal-hyprland &

echo "Starting Tray applets..."
flatpak run org.signal.Signal --start-in-tray &
flatpak run com.rtosta.zapzap --start-hidden

#nm-applet &
##pamac-tray &
#volumeicon &
##xfce4-power-manager &
##numlockx on &
##blueberry-tray &
#
#

#notify-send -t 3000 "Qtile AutoStart" "All Autostart Apps Loaded..."
