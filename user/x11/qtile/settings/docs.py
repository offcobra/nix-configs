#!/usr/bin/env python3
import os

from libqtile.config import Key, KeyChord

#from prettytable import PrettyTable

from settings.keybindings import keybindings

mod4 = 'mod'

DOCS = '/home/wally/.config/docs/new_shortcuts.txt'
FILE = '/home/wally/.config/qtile/settings/screens.py'

def check_3screens():
    ''' Check if screen mod is 3screens '''
    # Only write docs if 3screens mod
    if os.path.islink(FILE):
        original = os.readlink(FILE)
        bool_screens = bool(original.endswith("3screens.py"))
    else:
        bool_screens = False
    return bool_screens


def _format_commands(commands):
    ''' Function to format Qtile Commands... '''
    comm = []
    spawn = False
    for co in commands:
        if co.name == 'spawn':
            comm.append(co.args[0])
            spawn = True
        else:
            comm.append(co.name)
    return comm, spawn


def format_keys(q_keys: list):
    ''' Function to format the Keybindings '''
    comm = {
        "navigation": [],
        "spawn": []
    }
    for k in q_keys:
        if isinstance(k, Key):
            comms, spawn = _format_commands(k.commands)
            if spawn:
                comm['spawn'].append({
                    "modifiers": " + ".join(k.modifiers),
                    "keys": k.key,
                    "commands": " ".join(comms),
                    "desc": k.desc
                })
            else:
                comm['navigation'].append({
                    "modifiers": " + ".join(k.modifiers),
                    "keys": k.key,
                    "commands": " ".join(comms),
                    "desc": k.desc
                })
        elif isinstance(k, KeyChord):
            x = []
            x.extend(k.modifiers)
            x.append(k.key)
            modif = " + ".join(x)
            title = k.name.lower().replace(" ", "_")
            comm[title] = []
            for subk in k.submappings:
                comms, spawn = _format_commands(subk.commands)
                comm[title].append({
                    "modifiers": modif,
                    "keys": subk.key,
                    "commands": " ".join(comms),
                    "desc": subk.desc
                })

    return comm


def pretty_print(keys):
    ''' Pretty Table print keys '''
    f_keys = format_keys(keys)
    tables = []
    for x in f_keys:
        if x == "navigation":
            continue
        pretty = PrettyTable()
        pretty.field_names = ["Modifiers", "Key", "Commands", "Description"]
        pretty.title = f"Table for displaying {x.title()} Keybindings..."
        for k in f_keys[x]:
            pretty.add_row([k["modifiers"], k["keys"], k["commands"], k["desc"]])
        tables.append(pretty)
    return tables

#def set_docs():
#    ''' Function to be called on every reload '''
#    if check_3screens():
#        # clear file
#        open(DOCS, 'w').close()
#        tables = pretty_print(keybindings)
#        with open(DOCS, 'a', encoding='utf-8') as f_docs:
#            for tab in tables:
#                f_docs.write(' \n')
#                f_docs.write(str(tab))
#                f_docs.write(' \n')
#


if __name__ == '__main__':
    ''' Main for Test '''
    print('### == > Keys module called...')
    keys = keybindings
    pretty_print(keys)

