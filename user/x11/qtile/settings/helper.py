''' Module to host the helder Functions. '''
from random import randint

#import netifaces
import subprocess


COUNTRIES = [
    "Albania", "Austria", "Belgium", "Bulgaria", "Croatia", "Cyprus",
    "Czech_Republic", "Denmark", "Estonia", "Finland", "Germany", "Greece",
    "Hungary", "Italy", "Lithuania", "Luxembourg", "Moldova", "North_Macedonia",
    "Norway", "Poland", "Portugal" ,"Romania", "Serbia", "Slovakia", "Slovenia",
    "Switzerland", "Spain", "Sweden", "Turkey"
]


# Functions #
#------------
def to_next(qtile):
    ''' to next '''
    i = qtile.screens.index(qtile.current_screen)
    if i <= 1:
        qtile.cmd_to_screen(i + 1)
    else:
        qtile.cmd_to_screen(0)

def to_prev(qtile):
    ''' to prev '''
    i = qtile.screens.index(qtile.current_screen)
    if i > 0:
        qtile.cmd_to_screen(i - 1)
    else:
        qtile.cmd_to_screen(2)

def window_to_previous_screen(qtile, switch_group=False, switch_screen=False):
    ''' Window to previousprevious  screen'''
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen is True:
            qtile.cmd_to_screen(i - 1)

def window_to_next_screen(qtile, switch_group=False, switch_screen=False):
    ''' Window to next screen'''
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen is True:
            qtile.cmd_to_screen(i + 1)


def get_vpn_data():
    ''' Get Data from vpn status '''
    cmd = 'nordvpn status'
    process = subprocess.run(cmd.split(), stdout=subprocess.PIPE, check=True).stdout.decode('utf-8')
    data = process.split("\r")[-1]
    data = data.split("\n")
    cache = '{} - {} '
    for item in data:
        if 'Country' in item:
            country = item.split(": ")[-1]
        if 'IP' in item:
            ip = item.split(": ")[-1]
    result = cache.format(country, ip)
    return result


#def check_vpn():
#    ''' Check if VPN is Actrive '''
#    process = netifaces.interfaces()
#    if 'nordlynx' in process:
#        result = '⮝ vpn: NordVPN => ' + get_vpn_data()
#    elif 'tun0' in process:
#        result = '⮝ vpn: HackTheBox => {} '.format(netifaces.ifaddresses('tun0')[2][0]['addr'])
#    else:
#        result = '⮝ vpn: no '
#    return result
#
#
#def vpn_toggle():
#    ''' Toggles the VPN connection to NordVpn '''
#    status = check_vpn()
#    if 'no' in status:
#        country = COUNTRIES[randint(0, len(COUNTRIES) - 1)]
#        response = f" -e nordvpn connect {country}"
#    elif 'NordVPN' in status:
#        response = " -e nordvpn disconnect"
#    else:
#        response = " --hold -e echo '#=-> Nothing to do... Status unknown!!! '"
#    return response
#

def check_cpu():
    ''' Check for CPU state '''
    cmd = 'cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor'
    state = subprocess.run(cmd.split(), stdout=subprocess.PIPE, check=True).stdout.decode('utf-8')
    #return state.replace("\n", "")
    # ""
    #return "  => {}".format(state.replace("\n", ""))
    return "{}".format(state.replace("\n", ""))


def toggle_cpu():
    ''' Toggle CPU from ondemand to performance '''
    state = check_cpu()
    if not 'performance' in check_cpu():
        new_state = 'performance'
    else:
        new_state = 'ondemand'
    return new_state
